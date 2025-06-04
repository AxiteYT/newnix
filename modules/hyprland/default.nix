{ pkgs, ... }:
{
  # Enable hyprland
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  # Set electron apps to use hyprland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Required packages
  environment.systemPackages = with pkgs; [
    kitty
  ];
}
