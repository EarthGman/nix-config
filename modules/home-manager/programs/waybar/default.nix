{ pkgs, lib, config, hostName, ... }:
{
  options.programs.waybar = {
    theme = lib.mkOption {
      description = "theme for waybar";
      type = lib.types.str;
      default = "default";
    };
  };
  config = {
    programs.waybar = {
      settings = import ./settings.nix { inherit pkgs lib config hostName; };
      style = builtins.readFile ./themes/${config.programs.waybar.theme}/style.css;
    };
    home.packages = lib.mkIf config.programs.waybar.enable (with pkgs; [
      (nerdfonts.override { fonts = [ "Meslo" ]; })
    ]);
  };
}
