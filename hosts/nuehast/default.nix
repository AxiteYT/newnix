{ pkgs, ... }:
{
  imports = [
    ../default.nix
    ../../modules/nextcloud/default.nix
    ../../hardware/qemu-guest/default.nix
    ./network-config.nix
  ];

  # Add nuehast user
  users.users.nuehast = {
    isNormalUser = true;
    home = "/home/nuehast";
    description = "nuehast User";
    extraGroups = [
      "wheel"
      "networkmanager"
      "nuehast"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINMXEwWst3Kkag14hG+nCtiRX8KHcn6w/rUeZC5Ww7RU axite@axitemedia.com"
    ];
  };
}
