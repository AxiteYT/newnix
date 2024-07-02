{ pkgs, ... }: {
  # WG Application
  environment.systemPackages = with pkgs;
    [
      wireguard-tools
    ];

  # WireGuard VPN Configuration
  networking.wg-quick.interfaces = {
    wg0 = {
      address = [ "10.2.0.2/32" ];
      dns = [ "10.2.0.1" ];
      privateKeyFile = "/root/.wg/besta-AU-1.key";
      peers = [{
        publicKey = "hPKSC01LiQsP+1pzPm98CFZXqkESBuwqdmMe+4ujeEs=";
        endpoint = "103.216.220.98:51820";
        allowedIPs = [ "0.0.0.0/0" ];
      }];

      # postRules to allow localtraffic
      postUp = ''
        ${pkgs.iptables}/bin/iptables -I OUTPUT ! -o wg0 -m mark ! --mark $(wg show wg0 fwmark) -m addrtype ! --dst-type LOCAL ! -d 192.168.1.0/24 -j REJECT && ip6tables -I OUTPUT ! -o wg0 -m mark ! --mark $(wg show wg0 fwmark) -m addrtype ! --dst-type LOCAL -j REJECT;
      '';
      postDown = ''
        ${pkgs.iptables}/bin/iptables -D OUTPUT ! -o wg0 -m mark ! --mark $(wg show wg0 fwmark) -m addrtype ! --dst-type LOCAL ! -d 192.168.1.0/24 -j REJECT && ip6tables -D OUTPUT ! -o wg0 -m mark ! --mark $(wg show wg0 fwmark) -m addrtype ! --dst-type LOCAL -j REJECT
      '';
    };
  };
}
