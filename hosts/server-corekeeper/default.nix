{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.steamPackages.steamcmd
  ];
}
