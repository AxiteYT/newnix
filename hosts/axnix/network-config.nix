{ config, lib, ... }:
{
  networking = {
    hostName = "axnix";
    networkmanager.enable = true;
    useDHCP = lib.mkForce true;
  };
}
