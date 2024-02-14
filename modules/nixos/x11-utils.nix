{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    xorg.xkbcomp # key remapper for x11
    xorg.xmodmap # key remapper for x11
    xorg.xev # information processor for keystrokes
  ];
}
