{ lib, config, users, myLib, ... }:
let
  usernames = if (users != "") then myLib.splitToList users else [ ];
in
{
  options.modules.onepassword.enable = lib.mkEnableOption "enable 1password";
  config = lib.mkIf config.modules.onepassword.enable {
    programs = {
      _1password.enable = true;
      _1password-gui = {
        enable = true;
        polkitPolicyOwners = usernames;
      };
    };
  };
}
