{ username, lib, myLib, config, ... }:
let
  usernames = myLib.splitToList username;
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
