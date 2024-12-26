{ pkgs, ... }:
{
  imports = [
    ../../hardware/amd
    ../../modules/flatpak
    #../../modules/hyprland
    ../../modules/kde
    ../../modules/steam
    ../../mounts/apollo.nix
    ../default.nix
    ./kernel.nix
    ./network-config.nix
  ];

  # System Packages
  environment.systemPackages = with pkgs; [
    cargo
    cifs-utils
    ffmpeg-full
    gamemode
    input-remapper
    killall
    lutris
    libreoffice-qt
    neovim
    nixpkgs-fmt
    ntfs3g
    ollama
    patchelf
    powershell
    protontricks
    rpcs3
    vim
    vlc
    wayland-utils
    winetricks
    wineWowPackages.waylandFull
    xdotool
    xorg.xprop
    xorg.xrandr
    xorg.xwininfo
    yad
  ];

  # Enable sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    jack.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
  };
  hardware.pulseaudio.enable = false;

  # Enable Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
      };
    };
  };
}
