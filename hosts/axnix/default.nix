{ pkgs, ... }: {
  imports = [
    ../default.nix
    ./kernel.nix
    ./network-config.nix
    ../../modules/steam/default.nix
    ../../modules/kde/default.nix
    ../../modules/flatpak/default.nix
    ../../hardware/amd/default.nix
    ../../mounts/apollo.nix
  ];

  # Add axite user
  users.users.axite = {
    isNormalUser = true;
    description = "Kyle Smith";
    extraGroups = [
      "networkmanager"
      "wheel"
      /*"flatpak"*/
    ];
  };

  # System Packages
  environment.systemPackages = with pkgs; [
    btop
    cargo
    cifs-utils
    ffmpeg-full
    gamemode
    gawk
    input-remapper
    killall
    lutris
    neofetch
    neovim
    nixpkgs-fmt
    ntfs3g
    ollama
    patchelf
    powershell
    protontricks
    steamcmd
    tree
    unzip
    vim
    vlc
    wayland-utils
    wget
    wineWowPackages.waylandFull
    winetricks
    xdotool
    xorg.xprop
    xorg.xrandr
    xorg.xwininfo
    yad
  ];

  # Nix settings
  nix = {
    gc = {
      automatic = true;
      randomizedDelaySec = "14m";
      options = "--delete-older-than 10d";
    };
  };
}
