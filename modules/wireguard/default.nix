{ pkgs, ... }:
{
  # WG Application
  environment.systemPackages = with pkgs; [
    wireguard-tools
    libnatpmp
  ];

  # WireGuard VPN Configuration
  networking.wg-quick.interfaces = {
    wg0 = {
      address = [ "10.2.0.2/32" ];
      dns = [ "10.2.0.1" ];
      privateKeyFile = "/root/.wg/besta-AU-1.key";
      peers = [
        {
          publicKey = "zD4qEIk4HqXDJ5vHE9G34EUUhEybyBhA/Gs8NrfOdmI=";
          endpoint = "146.70.174.194:51820";
          allowedIPs = [ "0.0.0.0/0" ];
        }
      ];

      # postRules to allow localtraffic
      postUp = ''
        wg set wg0 fwmark 51820
        ${pkgs.iptables}/bin/iptables -t mangle -A OUTPUT -o wg0 -m mark --mark $(wg show wg0 fwmark) -j ACCEPT
        ${pkgs.iptables}/bin/iptables -t mangle -A OUTPUT ! -o wg0 -m addrtype --dst-type LOCAL -j ACCEPT
        ${pkgs.iptables}/bin/iptables -t mangle -A OUTPUT ! -o wg0 -d 192.168.1.0/24 -j ACCEPT
        ${pkgs.iptables}/bin/iptables -t mangle -A OUTPUT ! -o wg0 -d 10.1.1.0/24 -j ACCEPT
        ${pkgs.iptables}/bin/iptables -t mangle -A OUTPUT ! -o wg0 -m mark --mark 0 -j MARK --set-xmark $(wg show wg0 fwmark)
      '';
      postDown = ''
        ${pkgs.iptables}/bin/iptables -t mangle -D OUTPUT -o wg0 -m mark --mark $(wg show wg0 fwmark) -j ACCEPT
        ${pkgs.iptables}/bin/iptables -t mangle -D OUTPUT ! -o wg0 -m addrtype --dst-type LOCAL -j ACCEPT
        ${pkgs.iptables}/bin/iptables -t mangle -D OUTPUT ! -o wg0 -d 192.168.1.0/24 -j ACCEPT
        ${pkgs.iptables}/bin/iptables -t mangle -D OUTPUT ! -o wg0 -d 10.1.1.0/24 -j ACCEPT
        ${pkgs.iptables}/bin/iptables -t mangle -D OUTPUT ! -o wg0 -m mark --mark 0 -j MARK --set-xmark 0

        ${pkgs.libnatpmp}/bin/natpmpc -a 1 0 tcp 26504 -g 10.2.0.1
      '';
    };
  };

  # IP Forwarding
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
}
