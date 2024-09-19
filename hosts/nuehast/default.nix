{ pkgs, ... }:
{
  imports = [
    ../../modules/nextcloud
    ../../mounts/nextcloud.nix
    ../server
    ./network-config.nix
  ];

  # Add nuehast user
  users.users.nuehast = {
    isNormalUser = true;
    home = "/home/nuehast";
    description = "nuehast User";
    extraGroups = [
      "networkmanager"
      "nuehast"
      "wheel"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINMXEwWst3Kkag14hG+nCtiRX8KHcn6w/rUeZC5Ww7RU axite@axitemedia.com"
    ];
  };
}
