{ pkgs, lib, ... }:
{
  imports = [ ./alacritty.nix ];

  programs = {
    alacritty = {
      enable = true;

      settings = {
        window = {
          title = "Terminal";

          padding = {
            y = 5;
          };
          dimensions = {
            lines = 75;
            columns = 100;
          };
        };

        font = {
          normal.family = "JetbrainsMono Nerd Font";
          size = 8.0;
        };

        background_opacity = 0.3;

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
            sha256 = ninixpkgs.lib.fakeSha256;
          };
        }
        {
          name = "fast-syntax-highlighting";
          src = pkgs.fetchFromGitHub {
            owner = "zdharma";
            repo = "fast-syntax-highlighting";
            rev = "v1.66";
            sha256 = nixpkgs.lib.fakeSha256;
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
  };
}
