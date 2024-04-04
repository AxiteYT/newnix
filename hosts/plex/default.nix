{ modulesPath, config, lib, pkgs, ... }: {
  imports = [
    ../../modules/plex/default.nix
    ../../modules/qemu-guest/default.nix
    ./network-config.nix
  ];

  # Add plex user
  users.users.plex = {
    isNormalUser = true;
    home = "/home/plex";
    description = "plex User";
    extraGroups = [ "wheel" "networkmanager" "plex"];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINMXEwWst3Kkag14hG+nCtiRX8KHcn6w/rUeZC5Ww7RU axite@axitemedia.com"
    ];
  };
}
