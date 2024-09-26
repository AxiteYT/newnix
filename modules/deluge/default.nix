{ pkgs, ... }:
{
  #TODO: Depricated, remove this module when mind is made up.
  /*
  services.deluge = {
    enable = true;
    group = "servarr";
    declarative = true;
    authFile = pkgs.writeTextFile {
      name = "deluge-auth";
      text = ''
        localclient::10
      '';
    };
    web = {
      enable = true;
      openFirewall = true;
    };
    config = {
      enabled_plugins = [ "Label" "Scheduler" ];
      outgoing_interface = "wg0";
    };
  };
  */
}
