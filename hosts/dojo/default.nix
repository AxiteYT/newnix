{
  imports = [
    ../../hardware/nvidia
    ../../modules/steam/dojo.nix
    ../default.nix
    ./network-config.nix
  ];

  # Add dojo user
  users.users = {
    dojo = {
      isNormalUser = true;
      home = "/home/dojo";
      description = "dojo User";
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
