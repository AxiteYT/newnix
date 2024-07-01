{ pkgs, ... }:
{
  imports = [
    ../default.nix
    ../../modules/adguard/default.nix
    ../../hardware/qemu-guest/default.nix
    ./network-config.nix
  ];

  # Add elan user
  users.users.elan = {
    isNormalUser = true;
    home = "/home/elan";
    description = "Elan User";
    extraGroups = [ "wheel" "networkmanager" "servarr" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINMXEwWst3Kkag14hG+nCtiRX8KHcn6w/rUeZC5Ww7RU axite@axitemedia.com"
    ];
  };
}
