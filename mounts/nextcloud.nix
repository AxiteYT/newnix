{
  fileSystems."/media/Nextcloud" = {
    device = "10.0.1.99:/mnt/Core-Pool/Nextcloud";
    fsType = "nfs";
    options = [ "nfsvers=4.2" ];
  };
}
