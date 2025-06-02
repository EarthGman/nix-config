{ lib, config, ... }:
{
  options.modules.nh.enable = lib.mkEnableOption "enable custom nh module";
  config = lib.mkIf config.modules.nh.enable {
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = lib.mkDefault "--keep-since 4d --keep 3";
    };
    environment.variables = {
      # https://github.com/nix-community/nh/issues/305
      NH_NO_CHECKS = "1";
    };
  };
}
