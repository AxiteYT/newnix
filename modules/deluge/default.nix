{
  services.deluge = {
    enable = true;
    group = "servarr";
    declarative = true;
    dataDir = "/media/Plex/Downloads";
    authFile = "/etc/nixos/deluge.auth";
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
