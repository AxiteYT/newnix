{
  networking = {
    #Hostname
    hostName = "elan";

    # Interface
    interfaces = {
      enp6s18.ipv4.addresses = [{
        address = "192.168.1.5";
        prefixLength = 24;
      }];
    };
  };
}
