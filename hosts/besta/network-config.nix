{ pkgs, ... }:
{
  # Networking Configuration
  networking = {
    #Hostname
    hostName = "besta";

    # Interface
    interfaces = {
      enp6s18.ipv4.addresses = [
        {
          address = "192.168.1.85";
          prefixLength = 24;
        }
      ];
      wg0 = {
        ipv4.routes = [
          {
            address = "192.168.1.0";
            prefixLength = 24;
          }
          {
            address = "10.1.20.0";
            prefixLength = 24;
          }
          {
            address = "10.1.30.0";
            prefixLength = 24;
          }
        ];
      };
    };
  };
}
