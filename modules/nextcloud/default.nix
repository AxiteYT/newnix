{ pkgs, ... }:
{
  environment.etc."nextcloud-admin-pass".text = "Trophy-Zealous-Skier4";
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud29;
    configureRedis = true;
    config.adminpassFile = "/etc/nextcloud-admin-pass";
    hostName = "nuehast";
    maxUploadSize = "50G";
    settings = {
      enabledPreviewProviders = [
        "OC\\Preview\\BMP"
        "OC\\Preview\\GIF"
        "OC\\Preview\\HEIC"
        "OC\\Preview\\JPEG"
        "OC\\Preview\\Krita"
        "OC\\Preview\\MarkDown"
        "OC\\Preview\\MP3"
        "OC\\Preview\\OpenDocument"
        "OC\\Preview\\PNG"
        "OC\\Preview\\TXT"
        "OC\\Preview\\XBitmap"
      ];
    };
  };
}
