{
  networking = {
    #Hostname
    hostName = "plex";

    # Interface
    interfaces = {
      enp6s18.ipv4.addresses = [
        {
          address = "10.0.1.77";
          prefixLength = 24;
        }
      ];
    };
  };
}
