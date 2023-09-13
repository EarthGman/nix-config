#apps that are packages instead of programs
 {pkgs, ... }:
 with pkgs; [
    (nerdfonts.override {fonts = ["SourceCodePro"];})
    gnomeExtensions.dash-to-panel
    obsidian
    gimp
    prismlauncher
    discord
    sysz
    qemu
    github-desktop
 ]