{
  networking = {
    domain = "axitemedia.com";
  };

  nix = {
    distributedBuilds = true;
    extraOptions = ''
      builders-use-substitutes = true
    '';

    # Optionally disable local building
    settings.max-jobs = 0;

    buildMachines = [
      {
        hostName = "munshi.axitemedia.com";
        system = "x86_64-linux";
        maxJobs = 2;
        speedFactor = 2;
        # Supported features is badly documented, important to add these, 
        # otherwise many big packages will still get build locally.
        supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
        mandatoryFeatures = [ ];
      }
    ];
  };
}
