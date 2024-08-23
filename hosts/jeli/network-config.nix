{
  networking = {
    #Hostname
    hostName = "jeli";

    # Interface
    interfaces = {
      enp6s18.ipv4.addresses = [
        {
          address = "192.168.1.4";
          prefixLength = 24;
        }
      ];
    };
  };
}
