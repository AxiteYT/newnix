{ pkgs, ... }:
let
  username = "axite";
in
{
  # Allow unfree packages
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
      permittedInsecurePackages = [ "openssl-1.1.1w" ];
    };
  };

  # Home config
  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    stateVersion = "24.05";

    # Editor
    sessionVariables = {
      EDITOR = "nano";
    };

    # Packages
    packages = with pkgs; [
      blender
      brave
      bitwarden
      davinci-resolve
      discord
      dolphinEmu
      filezilla
      gh
      gimp
      git
      github-desktop
      hunspell
      k4dirstat
      kdenlive
      lutris
      neofetch
      nixfmt
      patchelf
      protonup-qt
      prismlauncher # (Minecraft)
      remmina
      runelite
      runescape
      putty
      spotify
      unityhub
      virt-viewer
      vlc
      vscodium
      wgnord
      zed-editor
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
      plugins = map (plugin: pkgs.obs-studio-plugins.${plugin}) [
        "obs-vaapi"
        "obs-vkcapture"
        "obs-gstreamer"
        "wlrobs"
      ];
    };
  };
}
