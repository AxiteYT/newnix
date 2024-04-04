{ modulesPath, config, lib, pkgs, ... }: {
  imports = [
    ../deluge/default.nix
    ./bazarr/default.nix
    ./prowlarr/default.nix
    ./radarr/default.nix
    ./sonarr/default.nix
  ];

  users.groups.servarr = { };
}
