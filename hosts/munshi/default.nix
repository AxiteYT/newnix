{
  imports = [
    ../default.nix
    ../../hardware/qemu-guest/default.nix
    #../../modules/nixbuild/server/default.nix
    ./network-config.nix
  ];

  # Add munshi users
  users.users = {
    munshi = {
      isNormalUser = true;
      home = "/home/munshi";
      description = "munshi User";
      extraGroups = [
        "wheel"
        "networkmanager"
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINMXEwWst3Kkag14hG+nCtiRX8KHcn6w/rUeZC5Ww7RU axite@axitemedia.com"
      ];
    };
  };
}
