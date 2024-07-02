{ pkgs, ... }:
let
  wggateway = "10.2.0.1";
in
{

  # WG Application
  environment.systemPackages = with pkgs;
    [
      wireguard-tools
    ];

  # Networking Configuration
  networking = {
    #Hostname
    hostName = "besta";

    # Interface
    interfaces = {
      enp6s18.ipv4.addresses = [{
        address = "192.168.1.85";
        prefixLength = 24;
      }];
    };

    # WireGuard VPN Configuration
    wg-quick.interfaces = {
      wg0 = {
        address = [ "10.2.0.2/32" ];
        dns = [ "${wggateway}" ];
        privateKeyFile = "/root/.wg/besta-AU-1.key";
        peers = [{
          publicKey = "8kyi2e0ziUqhs+ooJYYI0yaVhv/bneUC1fhV5X2q/SE=";
          endpoint = "138.199.33.236:51820";
          allowedIPs = [ "0.0.0.0/0" ];
        }];
        # PostUp
        postUp = ''
          ip rule add from 192.168.1.0/24 table main prio 10
          ip rule add not from 192.168.1.0/24 table 1234 prio 20
          ip route add default via ${wggateway} dev wg0 table 1234
        '';
        # PostDown
        postDown = ''
          ip rule delete from 192.168.1.0/24 table main prio 10
          ip rule delete not from 192.168.1.0/24 table 1234 prio 20
        '';
      };
    };
  };
}