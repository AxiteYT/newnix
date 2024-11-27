{ config, pkgs, ... }:

{
  users.users.nixbuild = {
    isNormalUser = false;
    createHome = false;
    extraGroups = [ "nixbld" ];
    openssh.authorizedKeys.keys = [ "TODO: Add public key here" ];
  };

}
