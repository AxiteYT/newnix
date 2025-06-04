{ pkgs, ... }:
{
  # Enable hyprland
  programs.hyprland.enable = true;

  # Set electron apps to use hyprland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    kitty
  ];
}
