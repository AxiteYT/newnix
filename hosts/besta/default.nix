{
  config,
  lib,
  inputs,
  nixpkgs-flaresolverr-chromium-126,
  ...
}:
{
  imports = [
    ../../modules/servarr
    ../../modules/wireguard
    ../../mounts/plex.nix
    ../server
    ./network-config.nix
  ];

  # Add besta user
  users.users.besta = {
    isNormalUser = true;
    home = "/home/besta";
    description = "Besta User";
    extraGroups = [
      "networkmanager"
      "servarr"
      "wheel"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINMXEwWst3Kkag14hG+nCtiRX8KHcn6w/rUeZC5Ww7RU axite@axitemedia.com"
    ];
  };
}
