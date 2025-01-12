{ inputs, pkgs, config, lib, platform, ... }:
let
  inherit (lib) mkIf mkOption types getExe mkEnableOption;
  cfg = config.programs.prismlauncher;
in
{
  options.programs.prismlauncher = {
    enable = mkEnableOption "enable prismlauncher";
    package = mkOption {
      description = "package for prismlauncher to use";
      type = types.package;
      default = inputs.prismlauncher.packages.${platform}.default;
    };
  };
  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
    # By default prismlauncher finds java installed the nix store and sets the path directly to its location
    # however every time garbage collection happens this location may be removed if the hash was updated
    # So these binary files are declaratively placed in the prismlauncher directory so the link is never broken by an update
    xdg.dataFile = {
      "PrismLauncher/java/java_8".source = getExe pkgs.jdk8;
      "PrismLauncher/java/java_21".source = getExe pkgs.jdk21;
    };
  };
}
