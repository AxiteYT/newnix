{ self, nixpkgs, ... }: {
  # Set GPU in kenel
  boot.initrd.kernelModules = [ "amdgpu" ];

  # Set XServer/Wayland to use AMD
  services.xserver.videoDrivers = [ "amdgpu" ];

  # OpenGL configuration
  hardware.opengl = {
    # Enable Driver
    driSupport = true;
    driSupport32Bit = true;

    # Vulkan + OpenCL packages
    extraPackages = with nixpkgs; [
      rocmPackages.clr.icd
      amdvlk
    ];
    extraPackages32 = with nixpkgs; [
      driversi686Linux.amdvlk
    ];
  };

  # HIP Libraries override
  systemd.tmpfiles.rules =
    [ "L+    /opt/rocm/hip   -    -    -     -    ${nixpkgs.rocmPackages.clr}" ];
}
