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
          persistentKeepalive = 25;
        }
      ];

      # postRules to allow localtraffic
      postUp = ''
        wg set wg0 fwmark 51820
        ${pkgs.iptables}/bin/iptables -t mangle -A OUTPUT -o wg0 -m mark --mark 51820 -j ACCEPT
        ${pkgs.iptables}/bin/iptables -t mangle -A OUTPUT ! -o wg0 -m addrtype --dst-type LOCAL -j ACCEPT
        ${pkgs.iptables}/bin/iptables -t mangle -A OUTPUT ! -o wg0 -d 192.168.1.0/24 -j ACCEPT
        ${pkgs.iptables}/bin/iptables -t mangle -A OUTPUT ! -o wg0 -d 10.1.1.0/24 -j ACCEPT
        ${pkgs.iptables}/bin/iptables -t mangle -A OUTPUT ! -o wg0 -m mark --mark 0 -j MARK --set-xmark 51820
      '';

      postDown = ''
        ${pkgs.iptables}/bin/iptables -t mangle -D OUTPUT -o wg0 -m mark --mark 51820 -j ACCEPT
        ${pkgs.iptables}/bin/iptables -t mangle -D OUTPUT ! -o wg0 -m addrtype --dst-type LOCAL -j ACCEPT
        ${pkgs.iptables}/bin/iptables -t mangle -D OUTPUT ! -o wg0 -d 192.168.1.0/24 -j ACCEPT
        ${pkgs.iptables}/bin/iptables -t mangle -D OUTPUT ! -o wg0 -d 10.1.1.0/24 -j ACCEPT
        ${pkgs.iptables}/bin/iptables -t mangle -D OUTPUT ! -o wg0 -m mark --mark 0 -j MARK --set-xmark 0
      '';
    };
  };

  # NAT-PMP Port Mapping Service
  systemd.services.natpmp = {
    description = "NAT-PMP Port Mapping Renewal Service";
    after = [
      "network.target"
      "wg-quick-wg0.service"
    ];
    wants = [ "wg-quick-wg0.service" ];

    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.bash}/bin/bash -c '\
        previous_port=" "; \
        while true; do \
          output=$(${pkgs.libnatpmp}/bin/natpmpc -g 10.2.0.1 -a 1 0 tcp 60); \
          echo \"$output\"; \
          allocated_port=$(echo \"$output\" | grep \"Mapped public port\" | grep \"tcp\" | awk \"{print \$5}\"); \
          echo \"Allocated port: $allocated_port\"; \
          # Remove previous firewall rule \
          if [ ! -z \"$previous_port\" ]; then \
            ${pkgs.iptables}/bin/iptables -D INPUT -p tcp --dport $previous_port -j ACCEPT; \
          fi; \
          # Add new firewall rule \
          ${pkgs.iptables}/bin/iptables -I INPUT -p tcp --dport $allocated_port -j ACCEPT; \
          # Update previous_port \
          previous_port=$allocated_port; \
          # Write the allocated port to a file \
          echo \"$allocated_port\" > /var/run/allocated_port; \
          chmod 644 /var/run/allocated_port; \
          sleep 45; \
        done'";

      Restart = "always";
      RestartSec = 5;
    };
  };

  # IP Forwarding
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
}