{
  pkgs,
  lib,
  darwin,
  ...
}:
{
  nix = {
    useDaemon = true;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = false;
    };
  };
  nixpkgs.config.allowUnfree = true;

  # activationScripts are executed every time you boot the system or run `nixos-rebuild` / `darwin-rebuild`.
  system = {
    activationScripts.postUserActivation.text = ''
      # activateSettings -u will reload the settings from the database and apply them to the current session,
      # so we do not need to logout and login again to make the changes take effect.
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    defaults = {
      finder = {
        AppleShowAllExtensions = true;
        ShowPathbar = true;
        FXEnableExtensionChangeWarning = false;
      };
    };
  };

  # Homebrew
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";

    taps = [ ];
    brews = [
      "abseil"
      "alacritty"
      "aom"
      "aribb24"
      "at-spi2-core"
      "autoconf"
      "automake"
      "brotli"
      "cairo"
      "capstone"
      "cjson"
      "cmake"
      "cowsay"
      "cunit"
      "dav1d"
      "dbus"
      "desktop-file-utils"
      "docbook"
      "docbook-xsl"
      "dtc"
      "faac"
      "faad2"
      "fdk-aac"
      "ffmpeg@6"
      "flac"
      "fontconfig"
      "freetype"
      "frei0r"
      "fribidi"
      "gcc"
      "gdbm"
      "gdk-pixbuf"
      "gettext"
      "gh"
      "giflib"
      "git"
      "git-lfs"
      "glib"
      "glib-networking"
      "gmp"
      "gnu-getopt"
      "gnu-sed"
      "gnutls"
      "gobject-introspection"
      "graphene"
      "graphite2"
      "grep"
      "gsettings-desktop-schemas"
      "gstreamer"
      "gtk+3"
      "gtk-vnc"
      "gtk4"
      "harfbuzz"
      "hicolor-icon-theme"
      "highway"
      "hwloc"
      "icu4c"
      "imath"
      "isl"
      "jpeg-turbo"
      "jpeg-xl"
      "json-glib"
      "jsoncpp"
      "lame"
      "leptonica"
      "libarchive"
      "libass"
      "libb2"
      "libbluray"
      "libcuefile"
      "libepoxy"
      "libevent"
      "libgcrypt"
      "libgit2"
      "libgpg-error"
      "libidn2"
      "libiscsi"
      "libmicrohttpd"
      "libmpc"
      "libnghttp2"
      "libogg"
      "libpng"
      "libpsl"
      "libpthread-stubs"
      "libreplaygain"
      "librist"
      "libsamplerate"
      "libshout"
      "libslirp"
      "libsndfile"
      "libsodium"
      "libsoup"
      "libsoxr"
      "libssh"
      "libssh2"
      "libtasn1"
      "libtermkey"
      "libtiff"
      "libtool"
      "libunibreak"
      "libunistring"
      "libusb"
      "libusrsctp"
      "libuv"
      "libvidstab"
      "libvirt"
      "libvirt-glib"
      "libvmaf"
      "libvorbis"
      "libvpx"
      "libvterm"
      "libx11"
      "libxau"
      "libxcb"
      "libxdmcp"
      "libxext"
      "libxfixes"
      "libxi"
      "libxrender"
      "libxtst"
      "little-cms2"
      "llvm"
      "lpeg"
      "luajit"
      "luv"
      "lz4"
      "lzo"
      "m4"
      "mbedtls"
      "meson"
      "mpdecimal"
      "mpfr"
      "mpg123"
      "msgpack"
      "musepack"
      "ncurses"
      "neovim"
      "nettle"
      "ninja"
      "node@20"
      "numpy"
      "openblas"
      "opencore-amr"
      "openexr"
      "openjpeg"
      "openvino"
      "opus"
      "orc"
      "p11-kit"
      "pango"
      "pcre2"
      "phodav"
      "pixman"
      "pkg-config"
      "protobuf"
      "pugixml"
      "putty"
      "py3cairo"
      "pygobject3"
      "python-packaging"
      "python@3.10"
      "python@3.12"
      "qemu"
      "rav1e"
      "readline"
      "ripgrep"
      "rtmpdump"
      "rubberband"
      "rust"
      "sdl2"
      "shared-mime-info"
      "snappy"
      "speex"
      "spice-gtk"
      "spice-protocol"
      "sqlite"
      "srt"
      "srtp"
      "svt-av1"
      "taglib"
      "tbb"
      "tesseract"
      "theora"
      "tree"
      "tree-sitter"
      "unbound"
      "unibilium"
      "usbredir"
      "vde"
      "webp"
      "wget"
      "x264"
      "x265"
      "xmlto"
      "xorgproto"
      "xvid"
      "xz"
      "yajl"
      "z3"
      "zeromq"
      "zimg"
      "zstd"
    ];
    casks = [
      "macfuse"
      "powershell"
      "zed"
    ];
  };

  # Shell
  security.pam.enableSudoTouchIdAuth = true;
  environment.systemPackages = with pkgs; [ alacritty ];
  environment.shells = [ pkgs.alacritty ];

  # Timezone
  time.timeZone = "Australia/Sydney";

  # Fonts
  fonts = {
    packages = with pkgs; [
      material-design-icons
      font-awesome
      #TODO: Fix below when there is more doco for the breaking change:
      /*
      (nerdfonts.override {
        fonts = [
          "NerdFontsSymbolsOnly"
          "FiraCode"
          "JetBrainsMono"
          "Iosevka"
        ];
      })
      */
    ];
  };
}
