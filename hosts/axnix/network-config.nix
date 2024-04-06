{ config, lib, ... }:
{
  networking = {
    hostName = "axnix";
    networkmanager.enable = lib.mkForce true;
    useDHCP = true;
  };
}
