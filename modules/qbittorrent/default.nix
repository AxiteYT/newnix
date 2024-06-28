{ pkgs, nixflk, ... }: {
  services.qbittorrent = {
    enable = true;
    openFirewall = true;
  };
}
