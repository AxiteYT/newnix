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
          address = "10.0.1.85";
          prefixLength = 24;
        }
      ];
      wg0 = {
        ipv4.routes = [
          {
            address = "10.0.1.0";
            prefixLength = 24;
          }
          {
            address = "10.1.1.0";
            prefixLength = 24;
          }
        ];
      };
    };
  };
}
