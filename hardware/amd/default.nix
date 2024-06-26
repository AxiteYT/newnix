{ pkgs, ... }: {
  # Set GPU in kenel
  boot.initrd.kernelModules = [ "amdgpu" ];

  # Set XServer/Wayland to use AMD
  services.xserver.videoDrivers = [ "amdgpu" ];

  # HIP Libraries override
  systemd.tmpfiles.rules =
    [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];
}
