{
  imports = [
    ../qbittorrent
    #./bazarr
    ./flaresolverr
    ./nzbget
    ./prowlarr
    ./radarr
    ./readarr
    ./sonarr
  ];

  users.groups.servarr = { };
}
