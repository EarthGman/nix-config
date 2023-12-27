{ pkgs, ... }:
{
  home.packages = with pkgs; [
    discord
    prismlauncher # minecraft
    dolphin-emu-beta
    steam
    flips # IPS and BPS file patcher
    vinegar # bootstrapper for roblox
  ];
}
