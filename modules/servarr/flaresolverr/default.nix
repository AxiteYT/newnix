{
  /*
    nixpkgs.overlays = [
      (self: super: {
        flaresolverr =
          let
            # Import nixpkgs at the specific commit
            pkgs =
              import
                (builtins.fetchTarball {
                  url = "https://github.com/NixOS/nixpkgs/archive/ebbc0409688869938bbcf630da1c1c13744d2a7b.tar.gz";
                  sha256 = "0y32h1mf5aih7bd8xmj023mc971aac39y4nylgjkvjanv18kv1pg";
                })
                {
                  # Specify the system to ensure compatibility
                  inherit (super) system;
                  # Optionally inherit configuration if needed
                  config = super.config;
                };
          in
          # Use flaresolverr from the imported nixpkgs
          pkgs.flaresolverr;
      })
    ];
  */

  services.flaresolverr = {
    enable = true;
    openFirewall = true;
  };
}
