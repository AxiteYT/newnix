{
  networking = {
    #Hostname
    hostName = "nuehast";

    # Interface
    interfaces = {
      ens18.ipv4.addresses = [
        {
          address = "192.168.1.44";
          prefixLength = 24;
        }
      ];
    };
  };
}
