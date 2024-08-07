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
    kernelPackages = pkgs.linuxPackagesFor pkgs.linux_xanmod;

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
