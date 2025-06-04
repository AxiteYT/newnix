{ self, lib, ... }:
{
  imports = [
    ./alacritty
    ./themes
  ];

  home = {
    username = "axite";
    homeDirectory = lib.mkForce "/home/axite";
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
