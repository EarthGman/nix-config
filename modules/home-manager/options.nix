{ lib, ... }:
let
  inherit (lib) mkOption types;
in
{
  options = {
    preferredEditor = mkOption {
      description = "string exported as EDITOR env variable";
      default = "nano";
      type = types.str;
    };
    terminal = mkOption {
      description = "which terminal emulator is used by default";
      default = "kitty";
      type = types.str;
    };
  };
}
