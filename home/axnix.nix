{ self, nixpkgs, ... }: {

  # Home Manager

  # axite user
  home-manager.users.axite = { config, nixpkgs, ... }: {

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Home config
    home = {

      # State version
      stateVersion = "24.05";

      # Editor
      sessionVariables = {
        EDITOR = "codium";
      };

      # Packages
      packages = with nixpkgs;
        [
          brave
          #davinci-resolve # Big download :(
          discord
          dolphinEmu
          gh
          gimp
          hunspell
          k4dirstat
          lutris
          minecraft
          neofetch
          nixfmt
          patchelf
          protonup-qt
          putty
          spotify
          unityhub
          vlc
          vscodium
          wgnord
        ];
    };

    # Programs
    programs = {

      # Bash
      bash = {
        enable = true;
        initExtra = ''
          . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
        '';
      };

      # Git
      git = {
        enable = true;
        userName = "axite";
        userEmail = "kylesmthh@gmail.com";
      };

      # OBS
      obs-studio = {
        enable = true;
        package = nixpkgs.obs-studio;
        plugins =
          map (plugin: nixpkgs.obs-studio-plugins.${plugin}) [
            "obs-vaapi"
            "obs-vkcapture"
            "obs-gstreamer"
            "wlrobs"
          ];
      };
    };
  };
}
