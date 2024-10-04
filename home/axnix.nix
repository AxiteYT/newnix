{ pkgs, lib, ... }:
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
      TERMINAL = "alacritty";
    };

    # Packages
    packages = with pkgs; [
      bitwarden
      blender
      brave
      davinci-resolve
      discord
      dolphinEmu
      filezilla
      gh
      gimp
      git
      github-desktop
      gparted
      hunspell
      k4dirstat
      kdenlive
      lutris
      nixfmt-rfc-style
      patchelf
      prismlauncher # (Minecraft)
      protonup-qt
      putty
      remmina
      runelite
      runescape
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
        "obs-gstreamer"
        "obs-vaapi"
        "obs-vkcapture"
        "wlrobs"
      ];
    };

    alacritty = {
      enable = true;
      settings = {
        font = {
          normal = {
            family = "JetBrainsMono Nerd Font";
            style = "Regular";
          };
        };
        window = {
          opacity = 0.2;
          blur = true;
          dynamic_padding = true;
        };
        shell = {
          program = "${pkgs.zsh}/bin/zsh";
        };
      };
    };

    zsh = {
      enable = true;
      initExtraFirst = ''
        [ ! -d "$HOME/.zsh/fsh/" ] && mkdir $HOME/.zsh/fsh/
        export FAST_WORK_DIR=$HOME/.zsh/fsh/;
        export PATH=$PATH:~/tools
        export PATH=$PATH:~/.npm-global/bin
        export PATH="$PATH:/home/thomas/.protostar/dist/protostar"
      '';
      plugins = [
        {
          name = "zsh-autosuggestions";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-autosuggestions";
            rev = "v0.7.0";
            sha256 = "sha256-KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
          };
        }
        {
          name = "fast-syntax-highlighting";
          src = pkgs.fetchFromGitHub {
            owner = "zdharma";
            repo = "fast-syntax-highlighting";
            rev = "v1.66";
            sha256 = "sha256-uoLrXfq31GvfHO6GTrg7Hus8da2B4SCM1Frc+mRFbFc=";
          };
        }
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
        {
          name = "powerlevel10k-config";
          src = lib.cleanSource ./zsh;
          file = if pkgs.stdenv.isDarwin then "darwin.zsh" else "p10k.zsh";
        }
      ];
    };
  };
}
