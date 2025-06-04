{ self, ... }:
{
  imports = [
    ./alacritty
  ];

  home = {
    username = "axite";
    homeDirectory = "/home/axite";
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
