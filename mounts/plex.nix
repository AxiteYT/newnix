{
  fileSystems."/media/Plex" = {
    device = "10.0.1.99:/mnt/Core-Pool/Plex";
    fsType = "nfs";
    options = [ "nfsvers=4.2" ];
  };
}
