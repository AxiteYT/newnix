{ pkgs, nixflk, ... }:
{
  imports = [
    "${nixflk}/modules/services/torrent/qbittorrent.nix"
  ];

  services.qbittorrent = {
    enable = true;
    openFirewall = true;
    dataDir = "/var/lib/qbittorrent";
    user = "qbittorrent";
    group = "servarr";
    port = 8080;
  };
}
