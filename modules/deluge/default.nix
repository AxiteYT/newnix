{
  services.deluge = {
    enable = true;
    group = "servarr";
    declarative = true;
    dataDir = "/media/Plex/Downloads";
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
}
