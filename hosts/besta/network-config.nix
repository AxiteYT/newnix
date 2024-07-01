{
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
        dns = [ "10.2.0.1" ];
        privateKeyFile = "/root/.wg/besta-AU-1.key";
        postUp = ''
          ${pkgs.iptables}/bin/iptables -A FORWARD -i wg0 -j ACCEPT
          ${pkgs.iptables}/bin/iptables -A FORWARD -o wg0 -j ACCEPT
          ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.2.0.2/32 -o enp6s18 -j MASQUERADE
          ${pkgs.iptables}/bin/iptables -A INPUT -i enp6s18 -s 192.168.1.0/24 -j ACCEPT
        '';
        preDown = ''
          ${pkgs.iptables}/bin/iptables -D FORWARD -i wg0 -j ACCEPT
          ${pkgs.iptables}/bin/iptables -D FORWARD -o wg0 -j ACCEPT
          ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.2.0.2/32 -o enp6s18 -j MASQUERADE
          ${pkgs.iptables}/bin/iptables -D INPUT -i enp6s18 -s 192.168.1.0/24 -j ACCEPT
        '';
        peers = [{
          publicKey = "8kyi2e0ziUqhs+ooJYYI0yaVhv/bneUC1fhV5X2q/SE=";
          endpoint = "138.199.33.236:51820";
          allowedIPs = [ "0.0.0.0/0" "192.168.1.0/24" ];
        }];
      };
    };
  };
}
