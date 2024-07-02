{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    netbootxyz-efi
  ];

  # Netboot XYZ Configuration
  boot.loader.systemd-boot.netbootxyz = {
    enable = true;
  };
}
