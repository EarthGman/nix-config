{ pkgs, ... }:
{
  imports = [
    ./neofetch
  ];

  programs = {
    obs-studio.enable = true;
    git = {
      enable = true;
      userName = "EarthGman";
      userEmail = "EarthGman@protonmail.com";
      #aliases = { };
    };
    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
      settings = {
        version = 1;
      };
    };
  };

  home.packages = (with pkgs; [
    # productivity
    github-desktop
    lazygit
    gimp # image editor
    libreoffice # free microsoft office
    obsidian # note taker
    discord
    betterdiscordctl
    betterdiscord-installer
    remmina # remote desktop client
    gcolor3 # color hex grabber
    clipgrab # video downloader
    openshot-qt # video editor
    audacity # audio editor
    museeks # music app
    musescore # music composition
    flips # rom patcher
    filezilla # ftp client
    pika-backup # backup system based on borg

    # some commands
    steam-run # running DLL applications, has nothing to do with steam
    appimage-run # for appimages
    wmctrl # ctrl options for wm
    unrar-free # for that guy who only uploads stuff in .rar format
    bat
    eza
    fzf
    hstr
    htop
    nix-info
    ripgrep
    sysz
    lshw
    tree
    radeontop
    nvtopPackages.full
    powertop
    nix-prefetch-git
    ncdu
    jq
    yq-go
    dua
    openssl
    usbutils
    pciutils
    tldr
    ifuse
    libimobiledevice
    checkra1n
    usbmuxd
  ]) ++ (with pkgs.gst_all_1; [
    # gstreamer, needed for some media playing applications to work on linux
    gst-libav
    gst-plugins-bad
    gst-plugins-base
    gst-plugins-good
    gst-plugins-ugly
    gst-vaapi
    gstreamer
  ]);
}
