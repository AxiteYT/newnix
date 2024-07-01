{ pkgs, ... }:
{
  imports = [
    ../services/torrent/qbittorrent.nix
  ];

  environment.systemPackages = with pkgs; [
    certbot-full
  ];

  services.qbittorrent = {
    enable = true;
    openFirewall = true;
    dataDir = "/var/lib/qbittorrent";
    user = "qbittorrent";
    group = "servarr";
    port = 8443;
  };
}
