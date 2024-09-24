{
  services.deluge = {
    enable = true;
    group = "media";
    authFile = "/etc/nixos/deluge.auth";
    web = {
      enable = true;
      openFirewall = true;
    };
  };
}
