{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  # Set the system to use the XanMod kernel
  boot = {
    kernelPackages = lib.mkForce pkgs.linuxKernel.packages.linux_xanmod_latest;

    initrd = {
      availableKernelModules = [
        "ahci"
        "nvme"
        "sd_mod"
        "uas"
        "usbhid"
        "xhci_pci"
      ];
      kernelModules = [ ];
    };
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
