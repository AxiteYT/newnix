{ pkgs, ... }:
let
  wggateway = "10.2.0.1";
  localgateway = "192.168.1.1";
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
    # Hostname
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

        postUp = ''
          iptables -I OUTPUT ! -o wg0 -m mark ! --mark $(wg show wg0 fwmark) -m addrtype ! --dst-type LOCAL ! -d ${localsubnet} -j REJECT;
          ip6tables -I OUTPUT ! -o wg0 -m mark ! --mark $(wg show wg0 fwmark) -m addrtype ! --dst-type LOCAL -j REJECT;
        '';

        postDown = ''
          iptables -D OUTPUT ! -o wg0 -m mark ! --mark $(wg show wg0 fwmark) -m addrtype ! --dst-type LOCAL ! -d ${localsubnet} -j REJECT;
          ip6tables -D OUTPUT ! -o wg0 -m mark ! --mark $(wg show wg0 fwmark) -m addrtype ! --dst-type LOCAL -j REJECT;
        '';
      };
    };
  };
}
