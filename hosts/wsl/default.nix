{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # include NixOS-WSL modules
    <nixos-wsl/modules>
  ];

  wsl = {
    enable = true;
    defaultUser = "nixos";
  };

  boot.isContainer = true;
}
