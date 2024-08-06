{ users, lib, config, ... }:
let
  usernames = builtins.filter builtins.isString (builtins.split "," users);
in
{
  options.custom.enable1password = lib.mkEnableOption "enable 1password";
  config = lib.mkIf config.custom.enable1password {
    programs = {
      _1password.enable = true;
      _1password-gui = {
        enable = true;
        polkitPolicyOwners = usernames;
      };
    };
  };
}
