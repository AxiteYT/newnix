{ pkgs, ... }: {
  imports = [
    ../default.nix
    ../../modules/plex/default.nix
    ../../hardware/qemu-guest/default.nix
    ../../mounts/plex.nix
    ./network-config.nix
  ];

  # Enable Hardware decoding
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };

  hardware.opengl = {
    # hardware.graphics on unstable
    enable = true;
    extraPackages = with pkgs; [
      intel-vaapi-driver
    ];
  };

  environment.sessionVariables = { LIBVA_DRIVER_NAME = "i965"; };

  # Add plex user
  users.users.plexuser = {
    isNormalUser = true;
    home = "/home/plex";
    description = "Plex User";
    extraGroups = [ "wheel" "networkmanager" "plex" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINMXEwWst3Kkag14hG+nCtiRX8KHcn6w/rUeZC5Ww7RU axite@axitemedia.com"
    ];
  };
}
