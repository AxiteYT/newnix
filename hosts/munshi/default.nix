{
  imports = [
    #../../modules/nixbuild/server
    ../server
    ./network-config.nix
  ];

  # Add munshi users
  users.users = {
    munshi = {
      isNormalUser = true;
      home = "/home/munshi";
      description = "munshi User";
      extraGroups = [
        "networkmanager"
        "wheel"

      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINMXEwWst3Kkag14hG+nCtiRX8KHcn6w/rUeZC5Ww7RU axite@axitemedia.com"
      ];
    };
  };
}
