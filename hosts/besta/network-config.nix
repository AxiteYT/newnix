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
        dns = [
          "10.1.20.1"
          "10.2.0.1"
        ];
        privateKeyFile = "/root/.wg/besta-AU-1.key";
        peers = [{
          publicKey = "8kyi2e0ziUqhs+ooJYYI0yaVhv/bneUC1fhV5X2q/SE=";
          endpoint = "138.199.33.236:51820";
          allowedIPs = [
            "0.0.0.0/1"
            "128.0.0.0/2"
            "192.0.0.0/9"
            "192.128.0.0/11"
            "192.160.0.0/13"
            "192.168.0.0/24"
            "192.168.2.0/23"
            "192.168.4.0/22"
            "192.168.8.0/21"
            "192.168.16.0/20"
            "192.168.32.0/19"
            "192.168.64.0/18"
            "192.168.128.0/17"
            "192.169.0.0/16"
            "192.170.0.0/15"
            "192.172.0.0/14"
            "192.176.0.0/12"
            "192.192.0.0/10"
            "193.0.0.0/8"
            "194.0.0.0/7"
            "196.0.0.0/6"
            "200.0.0.0/5"
            "208.0.0.0/4"
            "224.0.0.0/3"
          ];
        }];
      };
    };
  };
}
