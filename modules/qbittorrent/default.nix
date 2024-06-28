{ pkgs, nixflk, ... }:
let
  qbittorrentModule = nixflk + "/modules/services/torrent/qbittorrent.nix";
in
{
  imports = [
    qbittorrentModule
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
