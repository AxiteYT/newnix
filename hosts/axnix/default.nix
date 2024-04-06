{ pkgs, ... }: {
  imports = [
    ./kernel.nix
    ./network-config.nix
    ./sound.nix
    ../../home/axnix.nix
    ../../modules/steam/default.nix
    ../../modules/kde/default.nix
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
}
