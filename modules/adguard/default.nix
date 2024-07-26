{ pkgs, lib, ... }:
{
  # AdGuard Home
  services.adguardhome = {
    enable = true;
    openFirewall = true;
    port = 3000;
  };

  # Firewall config
  config = {
    networking = {
      firewall = {
        allowedTCPPorts = [ 3000 ];
        allowedUDPPorts = [ 53 ];
      };
    };
  };
}
