{
  config,
  pkgs,
  nixpkgs-flaresolverr-chromium-126,
  ...
}:
let
  flaresolverrPkgs = import nixpkgs-flaresolverr-chromium-126 {
    inherit (pkgs) system;
  };
in
{
  services.flaresolverr = {
    enable = true;
    openFirewall = true;
    package = flaresolverrPkgs.flaresolverr;
  };
}
