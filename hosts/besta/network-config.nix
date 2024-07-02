{ pkgs, ... }:
let
  wggateway = "10.2.0.1";
  localsubnet = "192.168.1.0/24";
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

        # postUP
        postUp = ''
          ip route add ${localsubnet} dev enp6s18 proto static scope link table main
          ip rule add from ${localsubnet} table main prio 10
          ip rule add not from ${localsubnet} table 1234 prio 20
          ip route add default via ${wggateway} dev wg0 table 1234
        '';

        # postDown
        postDown = ''
          ip route del ${localsubnet} dev enp6s18 table main
          ip rule del from ${localsubnet} table main prio 10
          ip rule del not from ${localsubnet} table 1234 prio 20
        '';
      };
    };
  };
}
