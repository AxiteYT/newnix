{
  services.deluge = {
    enable = true;
    group = "servarr";
    authFile = "/etc/nixos/deluge.auth";
    web = {
      enable = true;
      openFirewall = true;
    };
  };
}
