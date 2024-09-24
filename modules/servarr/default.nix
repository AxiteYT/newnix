{
  imports = [
    #../qbittorrent
    ../deluge
    ./bazarr
    ./flaresolverr
    ./prowlarr
    ./radarr
    ./sonarr
  ];

  users.groups.servarr = { };
}
