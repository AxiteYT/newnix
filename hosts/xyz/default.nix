{
  imports = [
    ../../modules/netbootxyz
    ../server
    ./network-config.nix
  ];

  # Add xyz users
  users.users = {
    xyz = {
      isNormalUser = true;
      home = "/home/xyz";
      description = "xyz User";
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
