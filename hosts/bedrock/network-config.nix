{
  networking = {
    #Hostname
    hostName = "jeli";

    # Interface
    interfaces = {
      ens18.ipv4.addresses = [
        {
          address = "192.168.1.18";
          prefixLength = 24;
        }
      ];
    };
  };
}
