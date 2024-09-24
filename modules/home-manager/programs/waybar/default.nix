{ pkgs, lib, config, ... }:
{
  programs.waybar = {
    settings = import ./settings.nix { inherit pkgs lib config; };
    style = builtins.readFile ./style.css;
  };
  home.packages = lib.mkIf config.programs.waybar.enable (with pkgs; [
    (nerdfonts.override { fonts = [ "Meslo" ]; })
  ]);
}
