{ config, lib, nixpkgs, modulesPath, ... }: {
  # Set the system to use the XanMod kernel
  boot = {
    kernelPackages = nixpkgs.linuxPackagesFor nixpkgs.linux_xanmod;

    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "nvme"
        "usbhid"
        "uas"
        "sd_mod"
      ];
      kernelModules = [ ];
    };
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };
}
