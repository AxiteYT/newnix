{
  pkgs,
  lib,
  self,
  inputs,
  ...
}:
{
  imports = [
    "${self}/hardware/amd"
    "${self}/hardware/keychron"
    "${self}/modules/flatpak"
    "${self}/modules/hyprland"
    "${self}/modules/steam"
    "${self}/hosts"
    ./kernel.nix
    ./network-config.nix
  ];

  # System Packages
  environment.systemPackages = with pkgs; [
    bitwarden
    blender
    brave
    davinci-resolve
    discord
    dolphin-emu
    filezilla
    gh
    gimp
    git
    github-desktop
    gparted
    hunspell
    k4dirstat
    lutris
    nixfmt
    patchelf
    prismlauncher # (Minecraft)
    protonup-qt
    putty
    remmina
    ryujinx
    spotify
    unityhub
    virt-viewer
    vlc
    vscodium
    wgnord
    zed-editor
    bolt-launcher
    bottles
    cargo
    cifs-utils
    ffmpeg-full
    handbrake
    input-remapper
    killall
    lmstudio
    lutris
    libreoffice-qt
    neovim
    networkmanagerapplet
    nexusmods-app-unfree
    nixpkgs-fmt
    nodejs
    ntfs3g
    obsidian
    ollama
    patchelf
    piper
    powershell
    protontricks
    rpcs3
    vim
    vlc
    wayland-utils
    winetricks
    wineWowPackages.stable
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
  services.pulseaudio.enable = false;

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

  # Enable ratbag daemon
  services.ratbagd.enable = true;
}
