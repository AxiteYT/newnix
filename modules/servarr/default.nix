{
  imports = [
    ../qbittorrent/default.nix
    ./bazarr/default.nix
    ./flaresolverr/default.nix
    ./prowlarr/default.nix
    ./radarr/default.nix
    ./sonarr/default.nix
  ];

  users.groups.servarr = { };
}
