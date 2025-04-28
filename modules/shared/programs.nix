{ inputs, pkgs, lib, platform, ... }:
let
  inherit (lib)
    mkProgramOption
    mkEnableOption
    mkOption
    types;
in
{
  options.programs = {
    ardour = mkProgramOption {
      programName = "ardour";
      description = " an open source DAW";
      inherit pkgs;
    };

    audacity = mkProgramOption {
      programName = "audacity";
      description = "an open source audio editor";
      inherit pkgs;
    };

    autokey = mkProgramOption {
      programName = "autokey";
      description = "a python script manager for desktop automation";
      inherit pkgs;
    };

    bottles = mkProgramOption {
      programName = "bottles";
      description = "wine prefix manager";
      inherit pkgs;
    };

    burpsuite = mkProgramOption {
      programName = "burpsuite";
      inherit pkgs;
    };

    bustle = mkProgramOption {
      programName = "bustle";
      description = "a gui dbus viewer";
      inherit pkgs;
    };

    cbonsai = mkProgramOption {
      programName = "cbonsai";
      description = "a randomized bonsai tree generator for your terminal";
      inherit pkgs;
    };

    cemu = mkProgramOption {
      programName = "cemu";
      description = "Wii U emulator";
      inherit pkgs;
    };

    clipgrab = mkProgramOption {
      programName = "clipgrab";
      description = "a audio and video downloader";
      inherit pkgs;
    };

    cmatrix = mkProgramOption {
      programName = "cmatrix";
      description = "a matrix for your terminal";
      inherit pkgs;
    };

    cutentr = mkProgramOption {
      programName = "cutentr";
      packageName = "cute-ntr";
      description = "3ds streaming client for NTR CFW";
      inherit pkgs;
    };

    davinci-resolve = mkProgramOption {
      programName = "davinci-resolve";
      description = "a professional nonlinear video editor";
      inherit pkgs;
    };

    discord = mkProgramOption {
      programName = "discord";
      packageName = "vesktop";
      inherit pkgs;
    };

    dolphin-emu = mkProgramOption {
      programName = "dolphin-emu";
      description = "Wii and Gamecube emulator";
      inherit pkgs;
    };

    dosbox = mkProgramOption {
      programName = "dosbox";
      description = "emulator for DOS";
      packageName = "dosbox-staging";
      inherit pkgs;
    };

    easyeffects = mkProgramOption {
      programName = "easyeffects";
      description = "Equalizer, Compressor, and other audio effects";
      inherit pkgs;
    };

    ffxiv-launcher = mkProgramOption {
      programName = "ffxiv-launcher";
      packageName = "xivlauncher";
      description = "lancher for final fantasy 14";
      inherit pkgs;
    };

    filezilla = mkProgramOption {
      programName = "filezilla";
      description = "FTP client";
      inherit pkgs;
    };

    flips = mkProgramOption {
      programName = "flips";
      description = "floating ips ROM patcher";
      inherit pkgs;
    };

    gcolor = mkProgramOption {
      programName = "gcolor";
      packageName = "gcolor3";
      description = "GTK color picker app";
      inherit pkgs;
    };

    ghex = mkProgramOption {
      programName = "ghex";
      description = "GTK hex editor";
      inherit pkgs;
    };


    gimp = mkProgramOption {
      programName = "gimp";
      description = "open source image editor";
      inherit pkgs;
    };

    gnome-calculator = mkProgramOption {
      programName = "gnome-calculator";
      inherit pkgs;
    };

    gnome-clocks = mkProgramOption {
      programName = "gnome-clocks";
      inherit pkgs;
    };

    gnome-software = mkProgramOption {
      programName = "gnome-software";
      description = "flatpak frontend for gnome";
      inherit pkgs;
    };

    gnome-system-monitor = mkProgramOption {
      programName = "gnome-system-monitor";
      inherit pkgs;
    };

    gnucash = mkProgramOption {
      programName = "gnucash";
      description = "open source accounting for personal use or small businesses";
      inherit pkgs;
    };

    gscan2pdf = mkProgramOption {
      programName = "gscan2pdf";
      description = "app for document scanning";
      inherit pkgs;
    };

    gthumb = mkProgramOption {
      programName = "gthumb";
      description = "simple GTK image viewer";
      inherit pkgs;
    };

    helvum = mkProgramOption {
      programName = "helvum";
      description = "patchbay for pipewire";
      inherit pkgs;
    };

    john = mkProgramOption {
      programName = "john";
      description = "brute force password cracker";
      inherit pkgs;
    };

    kdiskmark = mkProgramOption {
      programName = "kdiskmark";
      description = "GUI disk benchmarking utility";
      inherit pkgs;
    };

    keymapp = mkProgramOption {
      programName = "keymapp";
      description = "ZSA keyboard monitoring software";
      inherit pkgs;
    };

    libreoffice = mkProgramOption {
      programName = "libreoffice";
      description = "office-suite";
      inherit pkgs;
    };

    lutris = mkProgramOption {
      programName = "lutris";
      description = "game manager for linux";
      inherit pkgs;
    };

    moonlight = mkProgramOption {
      programName = "moonlight";
      packageName = "moonlight-qt";
      description = "stream client for sunshine by lizardbyte";
      inherit pkgs;
    };

    museeks = mkProgramOption {
      programName = "museeks";
      description = "mp3 player and music manager";
      inherit pkgs;
    };

    musescore = mkProgramOption {
      programName = "musescore";
      description = "sheet music creation studio";
      inherit pkgs;
    };

    nautilus = mkProgramOption {
      programName = "nautilus";
      description = "GNOME file manager";
      inherit pkgs;
    };

    neovim-custom = {
      enable = mkEnableOption "custom neovim package";
      defaultEditor = mkEnableOption "nvim as $EDITOR";
      package = mkOption {
        description = "package for portable neovim";
        type = types.package;
        default = inputs.vim-config.packages.${platform}.default;
      };
      viAlias = mkEnableOption "viAlias";
      vimAlias = mkEnableOption "VimAlias";
    };

    obsidian = mkProgramOption {
      programName = "obsidian";
      description = "Note storage vault for .md";
      inherit pkgs;
    };

    okular = mkProgramOption {
      programName = "okular";
      packageName = "okular";
      description = "pdf viewer for KDE plasma";
      pkgs = pkgs.kdePackages;
    };

    openconnect = mkProgramOption {
      programName = "openconnect";
      description = "cisco vpn";
      inherit pkgs;
    };

    openshot = mkProgramOption {
      programName = "openshot";
      packageName = "openshot-qt";
      description = "simple, open-source video editor";
      inherit pkgs;
    };

    phoronix = mkProgramOption {
      programName = "phoronix";
      packageName = "phoronix-test-suite";
      description = "a CLI test suite for hardware benchmarking";
      inherit pkgs;
    };

    piper = mkProgramOption {
      programName = "piper";
      description = "frontend for ratbagd";
      inherit pkgs;
    };

    pipes = mkProgramOption {
      programName = "pipes";
      description = "pipes screensaver for terminal";
      inherit pkgs;
    };

    prismlauncher = mkProgramOption {
      programName = "prismlauncher";
      description = "open source minecraft launcher";
      inherit pkgs;
    };

    pwvucontrol = mkProgramOption {
      programName = "pwvucontrol";
      description = "pipewire volume control";
      inherit pkgs;
    };

    r2modman = mkProgramOption {
      programName = "r2modman";
      description = "thunderstore alternative";
      inherit pkgs;
    };

    rpi-imager = mkProgramOption {
      programName = "rpi-imager";
      description = "image creater for rasberry pi";
      inherit pkgs;
    };

    ryujinx = mkProgramOption {
      programName = "ryujinx";
      description = "nintendo switch emulator";
      inherit pkgs;
    };

    scrcpy = mkProgramOption {
      programName = "scrcpy";
      description = "android screen sharing via USB debugging";
      inherit pkgs;
    };

    simple-scan = mkProgramOption {
      programName = "simple-scan";
      description = "a simple document scanner";
      inherit pkgs;
    };

    sl = mkProgramOption {
      programName = "sl";
      description = "a steam locomotive for your terminal";
      inherit pkgs;
    };

    sparrow = mkProgramOption {
      programName = "sparrow";
      description = "bitcoin trading app written in python";
      inherit pkgs;
    };

    switcheroo = mkProgramOption {
      programName = "switcheroo";
      description = "app for quick image format conversion";
      inherit pkgs;
    };

    totem = mkProgramOption {
      programName = "totem";
      description = "video player from GNOME";
      inherit pkgs;
    };

    video-trimmer = mkProgramOption {
      programName = "video-trimmer";
      description = "simple video trimmer";
      inherit pkgs;
    };

    vlc = mkProgramOption {
      programName = "vlc";
      description = "simple video player written in QT";
      inherit pkgs;
    };

    xclicker = mkProgramOption {
      programName = "xclicker";
      description = "a simple autoclicker for X11";
      inherit pkgs;
    };

    zoom = mkProgramOption {
      programName = "zoom";
      packageName = "zoom-us";
      description = "video chat and meeting app";
      inherit pkgs;
    };
  };
}
