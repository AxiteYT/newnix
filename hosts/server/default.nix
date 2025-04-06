{
  modulesPath,
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    ../../hardware/qemu-guest
    ../default.nix
  ];

  # Disable DHCP
  networking = {
    useDHCP = false;
    defaultGateway = "192.168.1.1";
    nameservers = [ "192.168.1.1" ];
  };

  # Enable serial port
  boot.kernelParams = lib.mkDefault [
    "console=ttyS0,115200n8"
  ];
}
