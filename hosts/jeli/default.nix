{
  imports = [
    ../../modules/unifi
    ../server
    ./network-config.nix
  ];

  # Add jeli users
  users.users = {
    jeli = {
      isNormalUser = true;
      home = "/home/jeli";
      description = "jeli User";
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
