{ pkgs, lib, ... }:
{
  imports = [ ./default.nix ];

  services.xserver = {
    enable = true;
    autoLogin.user = "dojo";

    displayManager = {
      lightdm.enable = false;
      autoLogin.enable = true;
      gdm.enable = true;
    };
  };
  programs.steam.gamescopeSession.enable = true;
  programs.gamescope.enable = true;
}
