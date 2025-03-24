# this module is not finished
{ pkgs, lib, config, ... }:
let
  tomlFormat = pkgs.formats.toml { };
  cfg = config.programs.mov-cli;
  inherit (lib) mkEnableOption mkOption mkIf types mkDefault;

  mov-cli = cfg.package.overrideAttrs (old: {
    propagatedBuildInputs = old.propagatedBuildInputs ++ cfg.plugins;
  });
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

    plugins = mkOption {
      description = "plugins for mov-cli";
      type = types.listOf types.package;
      default = [ ];
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      mov-cli
    ];

    programs.mov-cli.plugins = mkDefault (with pkgs; [
      mov-cli-youtube
    ]);

    # import some default settings identical to those that mov-cli -e generates
    programs.mov-cli.settings = import ./settings.nix { inherit lib; };

    xdg.configFile."mov-cli/config.toml" = mkIf (cfg.settings != { }) {
      source = tomlFormat.generate "config.toml" cfg.settings;
    };
  };
}
