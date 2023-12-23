{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    xorg.xkbcomp
    xorg.xmodmap
    xorg.xev
    icewm
  ];
}
