{ pkgs, ... }:
{
  imports = [
    ../../modules/adguard/default.nix
    ../server/default.nix
    ./network-config.nix
  ];

  # Add elan user
  users.users.elan = {
    isNormalUser = true;
    home = "/home/elan";
    description = "Elan User";
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
