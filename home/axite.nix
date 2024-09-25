{ config, pkgs, ... }:
{
  home = {
    # User Definition
    username = "axite";
    homeDirectory = "/home/axite";

    # Packages that should be installed to the user profile.
    packages = with pkgs; [
      gh
      git
      gparted
      hunspell
      nixfmt-rfc-style
      putty
    ];

    stateVersion = "24.05";
  };

  # Allow unfree packages
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  # Terminal
  sessionVariables = {
    EDITOR = "nano";
    TERMINAL = "alacritty";
  };
  programgs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal.family = "JetbrainsMono Nerd Font";
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

  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
    };
    initExtraFirst = '''';
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
        src = lib.cleanSource ./p10k-config;
        file = "p10k.zsh";
      }
    ];
  };

  #TODO: Check if this is needed
  # Let Home Manager install and manage itself.
  #programs.home-manager.enable = true;
}
