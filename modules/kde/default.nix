{ self, nixpkgs, ... }:
{
  services = {
    # Configure keymap in X11
    xserver = {

      # Enable the X11 windowing system.
      enable = true;
      xkb = {
        layout = "au";
        variant = "";
      };

      # Enable the KDE Plasma Desktop environment
      displayManager = {
        sddm = {
          enable = true;
          wayland.enable = false;
        };
        defaultSession = "plasma";
      };
    };

    # Enable KDE Plasma
    desktopManager.plasma6.enable = true;
  };

  # Theming
  qt = {
    enable = true;
    style = "adwaita-dark";
  };

  # Fonts
  fonts = {
    packages = with nixpkgs; [
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
      (nerdfonts.override { fonts = [ "Meslo" ]; })
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

  # Enable dconf
  programs.dconf.enable = true;

  # Enable wayland for Chromium/Electron based applications
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
