{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gimp
    discord
    libreoffice
    sysz
    prismlauncher
    ncdu
    jq
    obsidian
    dconf
    dconf2nix
    dua
    wl-screenrec
    steam
    musescore
    dolphin-emu-beta
    steam-run
    openssl
    usbutils
    pciutils
    looking-glass-client
    davinci-resolve
    github-desktop

    #Gstreamer
    gst_all_1.gst-libav
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-vaapi
    gst_all_1.gstreamer
  ];
}
