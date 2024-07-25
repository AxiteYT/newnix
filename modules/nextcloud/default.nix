{ inputs, pkgs, ... }:
{
  imports = [ inputs.nextcloudPreconfigured.nixosModules.default ];
  services.nextcloudPreconfigured = {
    enable = true;
    # Set this to the desired nextcloud version & increment the version when you want to update.
    # Nextcloud does not support multiple version upgrades, so the version shouldn't be incremented
    # by more than 1 at a time.
    package = pkgs.nextcloud29;
    openFirewall = true;
    # Requires `hostName` to be a publicly reachable domain pointed at this server for getting Let's Encrypt certs.
    enableHttps = false;
    # Replace this by your domain (or your IP / `localhost` if you don't want to access Nextcloud via a domain name).
    hostName = "nextcloud.axitemedia.com";

    adminuser = "admin";
    adminpassFile = "/etc/nextcloud/initial-admin-pass";
  };

  environment.etc."nextcloud/initial-admin-pass".text = "Trophy-Zealous-Skier4";
  services.nextcloud.dataDir = "/media/Nextcloud";
}
