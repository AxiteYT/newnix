{ modulesPath, config, lib, pkgs, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk-config.nix
  ];

  # Bootloader configuration
  boot.loader.grub = {
    # no need to set devices, disko will add all devices that have a EF02 partition to the list already
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  # Enable SSH
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINMXEwWst3Kkag14hG+nCtiRX8KHcn6w/rUeZC5Ww7RU axite@axitemedia.com"
  ];
  services.openssh.enable = true;

  environment.systemPackages = map lib.lowPrio [
    pkgs.curl
    pkgs.gitMinimal
  ];

  # Enable the Nix command and flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Set TimeZOne

  time.timeZone = "Australia/Sydney";

  # Disable IPv6
  networking.enableIPv6 = false;

  # Allow unfree packages
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  system.stateVersion = "24.05";
}
