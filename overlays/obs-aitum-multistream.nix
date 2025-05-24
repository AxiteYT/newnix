self: super: {
  obs-studio-plugins = super.obs-studio-plugins // {
    obs-aitum-multistream = super.qt6Packages.callPackage ./obs-aitum-multistream-src.nix { };
  };
}
