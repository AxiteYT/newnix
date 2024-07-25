{ pkgs, ... }:
{
  # Nextcloud
  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  services = {
    nextcloud = {
      enable = true;
      config.dbtype = "mysql";
      autoUpdateApps.enable = true;
      database.createLocally = true;
      configureRedis = true;
      hostName = "nuehast.axitemedia.com";
      https = true;
      home = "/media/Nextcloud";
    };

    nginx.virtualHosts."nuehast.axitemedia.com" = {
      forceSSL = true;
      enableACME = true;
    };
  };
}
