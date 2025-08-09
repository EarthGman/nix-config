{ lib, config, ... }:
{
  options.gman.onepassword.enable = lib.mkEnableOption "1password cli and gui";
  config = lib.mkIf config.gman.onepassword.enable {
    programs = {
      _1password.enable = true;
      _1password-gui = {
        enable = true;
      };
    };
  };
}
