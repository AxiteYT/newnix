{ pkgs, ... }:
{
  programs.steam = {
    enable = true;

    # Networking
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
}
