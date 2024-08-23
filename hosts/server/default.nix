{ ... }:
{
  imports = [
    ../../hardware/qemu-guest/default.nix
    ../default.nix
  ];

  # Disable DHCP
  networking = {
    useDHCP = false;
    defaultGateway = "10.0.1.1";
    nameservers = [ "10.0.1.1" ];
  };
}
