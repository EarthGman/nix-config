{ lib, config, users, ... }:
{
  options.modules.onepassword.enable = lib.mkEnableOption "enable 1password";
  config = lib.mkIf config.modules.onepassword.enable {
    programs = {
      _1password.enable = true;
      _1password-gui = {
        enable = true;
        polkitPolicyOwners = lib.mkDefault users;
      };
    };
  };
}
