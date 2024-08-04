{ pkgs, lib, config, displayManagerTheme, desktop, ... }:
let
  hasTheme = (displayManagerTheme != null);
  desktops = builtins.filter builtins.isString (builtins.split "," desktop);
in
{
  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;
    wayland = {
      enable = true;
    };
    extraPackages = lib.mkIf hasTheme (with pkgs; [
      sddm-themes.${displayManagerTheme}
    ]);
    theme = lib.mkIf hasTheme "${displayManagerTheme}";
  };
  environment.systemPackages = [
    pkgs.sddm-themes.${displayManagerTheme}
  ];
}

