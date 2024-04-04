{
  networking = {
    #Hostname
    hostName = "besta";

    # Gateway
    defaultGateway = "192.168.1.1";
    nameservers = [ "192.168.1.1" ];

    # Interface
    interfaces = {
      enp6s18.ipv4.addresses = [{
        address = "192.168.1.15";
        prefixLength = 24;
      }];
    };
  };
}
