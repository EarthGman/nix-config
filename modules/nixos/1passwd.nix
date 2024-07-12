{ users, ... }:
let
  usernames = builtins.filter builtins.isString (builtins.split "," users);
in
{
  programs = {
    _1password.enable = true;
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = usernames;
    };
  };
}
