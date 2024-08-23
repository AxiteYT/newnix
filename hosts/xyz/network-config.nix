{
  networking = {
    #Hostname
    hostName = "xyz";

    # Interface
    interfaces = {
      enp6s18.ipv4.addresses = [
        {
          address = "10.0.1.12";
          prefixLength = 24;
        }
      ];
    };
  };
}
