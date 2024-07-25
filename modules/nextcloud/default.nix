{ pkgs, ... }:
{
  # Nextcloud
  environment.etc."/nextcloud/initial-admin-pass".text = "Trophy-Zealous-Skier4";

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  services = {
    nextcloud = {
      enable = true;
      package = pkgs.nextcloud29;
      autoUpdateApps.enable = true;
      database.createLocally = true;
      configureRedis = true;
      hostName = "nuehast.axitemedia.com";
      https = true;
      home = "/media/Nextcloud";
      config = {
        dbtype = "mysql";

        adminuser = "admin";
        adminpassFile = "/etc/nextcloud/initial-admin-pass";
      };
    };

    nginx.virtualHosts."nuehast.axitemedia.com" = {
      forceSSL = true;
      enableACME = true;
    };
  };

  security.acme = {
    acceptTerms = true;
    email = "axite@axitemedia.com";
  };
}
