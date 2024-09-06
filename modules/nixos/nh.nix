{ lib, config, ... }:
{
  options.custom.nh.enable = lib.mkEnableOption "enable nix helper a better nix cli";
  config = lib.mkIf config.custom.nh.enable {
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
    };
  };
}
