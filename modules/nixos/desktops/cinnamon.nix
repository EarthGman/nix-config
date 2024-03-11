{ pkgs, config, lib, ... }:
{
  services.xserver.desktopManager.cinnamon.enable = true;

  programs.geary.enable = false;
  environment.cinnamon.excludePackages = (with pkgs; [
    hexchat
    weather
    xed-editor
  ]) ++ (with pkgs.cinnamon; [
    nemo
    pix
  ]);
}
