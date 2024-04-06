{
  networking = {
    #Hostname
    hostName = "munshi";

    # Gateway
    defaultGateway = "192.168.1.1";
    nameservers = [ "192.168.1.1" ];

    # Interface
    interfaces = {
      enp6s18.ipv4.addresses = [{
        address = "192.168.1.7";
        prefixLength = 24;
      }];
    };
  };
}
