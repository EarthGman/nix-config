{ lib, config, ... }@args:
let
  users = if args ? users then args.users else [ ];
in
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
