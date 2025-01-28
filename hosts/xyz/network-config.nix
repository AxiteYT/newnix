{
  networking = {
    #Hostname
    hostName = "xyz";

    # Interface
    interfaces = {
      ens18.ipv4.addresses = [
        {
          address = "192.168.1.12";
          prefixLength = 24;
        }
      ];
    };
  };
}
