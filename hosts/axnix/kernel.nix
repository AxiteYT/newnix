{ pkgs, ... }: {
  # Set the system to use the XanMod kernel
  boot = {
    kernelPackages = pkgs.linuxPackagesFor pkgs.linux_xanmod;

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
    kernelModules = [ "kvm-intel" "wl" ];
    extraModulePackages = [
      config.boot.kernelPackages.broadcom_sta
    ];
  };
}
