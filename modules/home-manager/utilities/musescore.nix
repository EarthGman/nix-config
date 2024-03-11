{ pkgs, ... }:
{
  home.packages = with pkgs; [
    musescore # music composition app
  ];
}
