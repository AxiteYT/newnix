{ self, ... }:
{
  imports = [
    "${self}/home/alacritty/default.nix"
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
