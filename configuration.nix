{
  modulesPath,
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # Enable SSH
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINMXEwWst3Kkag14hG+nCtiRX8KHcn6w/rUeZC5Ww7RU axite@axitemedia.com"
  ];
  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [
    alacritty
    btop
    curl
    dig
    dmidecode
    gawk
    gitMinimal
    htop
    killall
    neofetch
    ookla-speedtest
    pciutils
    tmux
    tree
    unzip
    wget
  ];

  # Enable the Nix command and flakes
  nix.settings.experimental-features = [
    "flakes"
    "nix-command"
  ];

  # Set TimeZone
  time.timeZone = "Australia/Sydney";

  # Disable IPv6
  networking.enableIPv6 = false;

  # Allow unfree packages
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
      permittedInsecurePackages = [
        "aspnetcore-runtime-wrapped-6.0.36"
        "aspnetcore-runtime-6.0.36"
        "dotnet-sdk-wrapped-6.0.428"
        "dotnet-sdk-6.0.428"
      ];
    };
  };

  # Allow all firmware
  hardware.enableAllFirmware = true;

  # Set kernel to use latest Linux kernel
  boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;

  system.stateVersion = "24.05";
}
