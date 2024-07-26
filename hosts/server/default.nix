{ ... }:
{
  imports = [
    ../../hardware/qemu-guest/default.nix
    ../default.nix
  ];

  # Disable DHCP
  networking.useDHCP = false;
}
