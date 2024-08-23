{
  networking = {
    #Hostname
    hostName = "elan";

    # Interface
    interfaces = {
      enp6s18.ipv4.addresses = [
        {
          address = "10.0.1.5";
          prefixLength = 24;
        }
      ];
    };
  };
}
