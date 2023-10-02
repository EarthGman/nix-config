{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gimp
    discord
    libreoffice
    sysz
    prismlauncher
    grapejuice
    ncdu
    jq
    obsidian
    dconf
    dconf2nix
    dua
    wl-screenrec
    steam
    dolphin-emu
  ];
}
