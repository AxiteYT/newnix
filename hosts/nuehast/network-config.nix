{
  networking = {
    #Hostname
    hostName = "nuehast";

    # Interface
    interfaces = {
      enp6s18.ipv4.addresses = [
        {
          address = "10.0.1.44";
          prefixLength = 24;
        }
      ];
    };
  };
}
