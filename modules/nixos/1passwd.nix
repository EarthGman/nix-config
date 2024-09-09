{ lib, config, users, myLib, ... }:
let
  usernames = myLib.splitToList users;
in
{
  options.custom.onepassword.enable = lib.mkEnableOption "enable 1password";
  config = lib.mkIf config.custom.onepassword.enable {
    programs = {
      _1password.enable = true;
      _1password-gui = {
        enable = true;
        polkitPolicyOwners = usernames;
      };
    };
  };
}
