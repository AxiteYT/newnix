{ pkgs, ... }: {
  # Enable the qbittorrent service
  environment.systemPackages = with pkgs; [
    qbittorrent
  ];

  # Allow traffic to the qbittorrent port
  networking.firewall.allowedTCPPorts = [ 8080 ];

  # Create the qbittorrent user
  users.extraUsers.qbittorrent = {
    isSystemUser = true;
    home = "/var/lib/qbittorrent";
    description = "qbittorrent";
    group = "servarr";
    uid = 888;
    extraGroups = [ "servarr" ];
  };
}
