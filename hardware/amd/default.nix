{ pkgs, ... }:
{
  # Enable GPU Drivers
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      amdvlk
    ];
    extraPackages32 = with pkgs; [
      driversi686Linux.amdvlk
    ];
  };

  # Set GPU in kenel
  boot.initrd.kernelModules = [ "amdgpu" ];

  # Set XServer/Wayland to use AMD
  services.xserver.videoDrivers = [ "amdgpu" ];

  # HIP Libraries override
  systemd.tmpfiles.rules = [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];
}
