{
  networking = {
    #Hostname
    hostName = "munshi";

    # Interface
    interfaces = {
      ens18.ipv4.addresses = [
        {
          address = "192.168.1.7";
          prefixLength = 24;
        }
      ];
    };
  };
}
