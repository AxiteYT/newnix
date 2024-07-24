{ pkgs, ... }:
{
  imports = [ ../default.nix ];

  # Add axite user
  users.users.axite = {
    isNormalUser = true;
    home = "/home/axite";
    description = "axite User";
    extraGroups = [
      "networkmanager"
      "servarr"
      "wheel"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINMXEwWst3Kkag14hG+nCtiRX8KHcn6w/rUeZC5Ww7RU axite@axitemedia.com"
    ];
  };
}
