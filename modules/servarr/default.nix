{ modulesPath, config, lib, pkgs, ... }: {
  imports = [
    ./radarr/default.nix
    ./sonarr/default.nix
    ./bazarr/default.nix
    ./prowlarr/default.nix
    ../qbittorrent/default.nix
  ];
}
