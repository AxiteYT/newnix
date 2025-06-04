{ self, ... }:
{
  imports = [
    ./alacritty
    ./themes
  ];

  home = {
    username = "axite";
    homeDirectory = "/home/axite";
    stateVersion = "24.05";
  };

  programs = {
    # Git
    git = {
      enable = true;
      userName = "axite";
      userEmail = "kylesmthh@gmail.com";
    };
  };
}
