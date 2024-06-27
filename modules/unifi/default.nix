{ pkgs, ... }: {
  services.unifi = {
    enable = true;
    openFirewall = false;

    #Packages
    unifiPackage = pkgs.unifi8;
    mongodbPackage = pkgs.mongodb-6_0;
    jrePackage = pkgs.jdk17;
  };
}
