final: prev: {
  obs-studio-plugins = prev.obs-studio-plugins // {
    obs-aitum-multistream = final.qt6Packages.callPackage (final.fetchpatch {
      url = "https://github.com/NixOS/nixpkgs/pull/408767.patch";
      sha256 = "sha256-MWuTVjq8VOjidHQuhY9sIcXvdDSH/2MlsXXiHGH/ZhM=";
    }) { };
  };
}
