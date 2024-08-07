{ pkgs, ... }:
{
  # WG Application
  environment.systemPackages = with pkgs; [ wireguard-tools ];

  # WireGuard VPN Configuration
  networking.wg-quick.interfaces = {
    wg0 = {
      address = [ "10.2.0.2/32" ];
      dns = [ "10.2.0.1" ];
      privateKeyFile = "/root/.wg/besta-AU-1.key";
      peers = [
        {
          publicKey = "Trt8stfmQTk/VTzR3jx3SSAIi0SSOSDOTtMln9bd4jY=";
          endpoint = "180.149.229.130:51820";
          allowedIPs = [ "0.0.0.0/0" ];
        }
      ];

      # postRules to allow localtraffic
      postUp = ''
        wg set wg0 fwmark 51820
        ${pkgs.iptables}/bin/iptables -t mangle -A OUTPUT -o wg0 -m mark --mark $(wg show wg0 fwmark) -j ACCEPT
        ${pkgs.iptables}/bin/iptables -t mangle -A OUTPUT ! -o wg0 -m addrtype --dst-type LOCAL -j ACCEPT
        ${pkgs.iptables}/bin/iptables -t mangle -A OUTPUT ! -o wg0 -d 192.168.1.0/24 -j ACCEPT
        ${pkgs.iptables}/bin/iptables -t mangle -A OUTPUT ! -o wg0 -d 10.1.20.0/24 -j ACCEPT
        ${pkgs.iptables}/bin/iptables -t mangle -A OUTPUT ! -o wg0 -d 10.1.30.0/24 -j ACCEPT
        ${pkgs.iptables}/bin/iptables -t mangle -A OUTPUT ! -o wg0 -m mark --mark 0 -j MARK --set-xmark $(wg show wg0 fwmark)
      '';
      postDown = ''
        ${pkgs.iptables}/bin/iptables -t mangle -D OUTPUT -o wg0 -m mark --mark $(wg show wg0 fwmark) -j ACCEPT
        ${pkgs.iptables}/bin/iptables -t mangle -D OUTPUT ! -o wg0 -m addrtype --dst-type LOCAL -j ACCEPT
        ${pkgs.iptables}/bin/iptables -t mangle -D OUTPUT ! -o wg0 -d 192.168.1.0/24 -j ACCEPT
        ${pkgs.iptables}/bin/iptables -t mangle -D OUTPUT ! -o wg0 -d 10.1.20.0/24 -j ACCEPT
        ${pkgs.iptables}/bin/iptables -t mangle -D OUTPUT ! -o wg0 -d 10.1.30.0/24 -j ACCEPT
        ${pkgs.iptables}/bin/iptables -t mangle -D OUTPUT ! -o wg0 -m mark --mark 0 -j MARK --set-xmark 0
      '';
    };
  };

  # IP Forwarding
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
}
