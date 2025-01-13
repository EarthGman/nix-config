{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.autokey;

  # allow for useful modules to be accessible to autokey
  autokey = pkgs.autokey.overrideAttrs (prev: {
    propagatedBuildInputs = prev.propagatedBuildInputs ++ (with pkgs.python3Packages; [
      pyautogui
    ]);
  });
in
{
  options.programs.autokey = {
    enable = mkEnableOption "enable autokey, a python script manager";
    package = mkOption {
      description = "package for autokey to use";
      type = types.package;
      default = autokey;
    };
  };
  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
