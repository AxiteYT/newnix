{ pkgs, ... }:
{
  # Enable Cachix
  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  # Enabel hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # System Packages
  environment.systemPackages = with pkgs; [
    dunst
    eww
    kitty
    libnotify
    rofi-wayland
    swww
    waybar
    (waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    }))
  ];

  # Enable xdg-portal
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Enable electron apps to use wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Theming
  qt = {
    enable = true;
    style = "adwaita-dark";
  };

  # Fonts
  fonts = {
    packages = with pkgs; [
      font-awesome
      hunspellDicts.en_AU
      hunspellDicts.en_US
      libreoffice-qt
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      source-han-sans
      source-han-sans-japanese
      source-han-serif-japanese
      (nerdfonts.override {
        fonts = [
          "Meslo"
          "JetBrainsMono"
        ];
      })
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Meslo LG M Regular Nerd Font Complete Mono" ];
        serif = [
          "Noto Serif"
          "Source Han Serif"
        ];
        sansSerif = [
          "Noto Sans"
          "Source Han Sans"
        ];
      };
    };
  };
}
