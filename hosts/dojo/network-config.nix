{ config, lib, ... }:
{
  networking = {
    hostName = "dojo";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };
}
