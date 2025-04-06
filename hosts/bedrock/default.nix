{
  imports = [
    ../server
    ./network-config.nix
  ];

  # Add bedrock users
  users.users = {
    bedrock = {
      isNormalUser = true;
      home = "/home/bedrock";
      description = "bedrock User";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINMXEwWst3Kkag14hG+nCtiRX8KHcn6w/rUeZC5Ww7RU axite@axitemedia.com"
      ];
    };
  };

  # Disable Serial connection from server config
  boot.kernelParams = lib.mkForce [ ];

  # Waydroid
  virtualisation.waydroid.enable = true;
}
