{
  imports = [
    ../../modules/servarr/default.nix
    ../../hardware/qemu-guest/default.nix
    ../../mounts/plex.nix
    ./network-config.nix
  ];

  # Add besta user
  users.users.besta = {
    isNormalUser = true;
    home = "/home/besta";
    description = "Besta User";
    extraGroups = [ "wheel" "networkmanager" "servarr" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINMXEwWst3Kkag14hG+nCtiRX8KHcn6w/rUeZC5Ww7RU axite@axitemedia.com"
    ];
  };
}
