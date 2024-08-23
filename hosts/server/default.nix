{ ... }:
{
  imports = [
    ../../hardware/qemu-guest/default.nix
    ../default.nix
  ];

  # Disable DHCP
  networking = {
    useDHCP = false;
    defaultGateway = "192.168.1.1";
    nameservers = [ "192.168.1.1" ];
  };
}
