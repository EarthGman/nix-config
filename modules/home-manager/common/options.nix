{ lib, ... }:
let
  inherit (lib) mkOption types;
in
{
  options = {
    preferredEditor = mkOption {
      description = "string exported as EDITOR env variable";
      default = "code";
      type = types.str;
    };
  };
}
