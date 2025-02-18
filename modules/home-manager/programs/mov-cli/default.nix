# this module is not finished
{ pkgs, lib, config, ... }:
let
  tomlFormat = pkgs.formats.toml { };
  cfg = config.programs.mov-cli;
  inherit (lib) mkEnableOption mkOption mkIf types mkDefault;
in
{
  options.programs.mov-cli = {
    enable = mkEnableOption "enable mov-cli a movie viewer for the terminal";

    package = mkOption {
      description = "package for mov-cli to use";
      type = types.package;
      default = pkgs.mov-cli;
    };

    settings = mkOption {
      description = "settings written to ~/.config/mov-cli/config.toml";
      type = tomlFormat.type;
      default = { };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];

    # import some default settings identical to those that mov-cli -e generates
    programs.mov-cli.settings = import ./settings.nix { inherit lib; };

    xdg.configFile."mov-cli/config.toml" = mkIf (cfg.settings != { }) {
      source = tomlFormat.generate "mov-cli-settings" cfg.settings;
    };
  };
}
