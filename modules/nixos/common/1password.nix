{ users, hostname, lib, ... }:
{
  programs = lib.mkIf (hostname == "cypher" || hostname == "garth") {
    _1password.enable = true;
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = builtins.filter builtins.isString (builtins.split "," users);
    };
  };
}
