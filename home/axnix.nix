{ pkgs, ... }:
let
  username = "axite";
in
{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;



  # Home config
  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    stateVersion = "24.05";

    # Editor
    sessionVariables = {
      EDITOR = "codium";
    };

    # Packages
    packages = with pkgs;
      [
        brave
        davinci-resolve
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
        runelite
        RuneScape
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
      package = pkgs.obs-studio;
      plugins =
        map (plugin: pkgs.obs-studio-plugins.${plugin}) [
          "obs-vaapi"
          "obs-vkcapture"
          "obs-gstreamer"
          "wlrobs"
        ];
    };
  };
}

