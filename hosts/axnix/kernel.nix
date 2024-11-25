{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  boot = {
    kernelPackages = lib.mkForce pkgs.linuxPackages_xanmod_latest;

    initrd = {
      availableKernelModules = [
        "ahci"
        "nvme"
        "sd_mod"
        "uas"
        "usbhid"
        "iwlmvm"
        "iwlwifi"
        "xhci_pci"
      ];
      kernelModules = [ ];
    };
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
