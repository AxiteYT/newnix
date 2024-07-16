{ pkgs, ... }:
{
  programs.steam = {
    enable = true;

    # Networking
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;

    # Gamescope
    gamescopeSession = {
      enable = true;
    };

    # Packages
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };
}
