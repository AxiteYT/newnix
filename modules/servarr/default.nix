{
  imports = [
    ../qbittorrent
    #./bazarr
    ./flaresolverr
    ./prowlarr
    ./radarr
    ./readarr
    ./sonarr
  ];

  users.groups.servarr = { };
}
