{
  imports = [
    ../../hardware/qemu-guest/default.nix
    ./network-config.nix
  ];

  # Add munshi users
  users =
    {
      users = {
        munshi = {
          isNormalUser = true;
          home = "/home/munshi";
          description = "munshi User";
          extraGroups = [ "wheel" "networkmanager" ];
          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINMXEwWst3Kkag14hG+nCtiRX8KHcn6w/rUeZC5Ww7RU axite@axitemedia.com"
          ];
        };
        nixdist = {
          isSystemUser = true;
          createHome = false;
          uid = 500;
          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMgVKHHxs6a+KyUkzQyEGMXbY+2nJ3kVe8KJMoPRxjgl root@axnix"
          ];
          group = "nixdist";
          useDefaultShell = true;
        };
      };
      groups.nixdist = {
        gid = 500;
      };
    };
  nix.settings.trusted-users = [ "nixdist" ];
}
