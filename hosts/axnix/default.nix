{ pkgs, ... }:
{
  imports = [
    ../../hardware/amd/default.nix
    ../../modules/flatpak/default.nix
    ../../modules/kde/default.nix
    ../../modules/steam/default.nix
    ../../mounts/apollo.nix
    ../default.nix
    ./kernel.nix
    ./network-config.nix
  ];

  # Add axite user
  users.users.axite = {
    isNormalUser = true;
    description = "Kyle Smith";
    extraGroups = [
      "networkmanager"
      "wheel"
      # "flatpak"
    ];
  };

  # System Packages
  environment.systemPackages = with pkgs; [
    cargo
    cifs-utils
    ffmpeg-full
    gamemode
    input-remapper
    killall
    lutris
    neovim
    nixpkgs-fmt
    ntfs3g
    ollama
    patchelf
    powershell
    protontricks
    steamcmd
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

  # Nix settings
  nix = {
    gc = {
      automatic = true;
      randomizedDelaySec = "14m";
      options = "--delete-older-than 10d";
    };
  };
}
