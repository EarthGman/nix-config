{ lib, ... }:
let
  inherit (lib) mkOption;
in
{
  options = {
    preferredEditor = lib.mkOption {
      description = "editor most apps will use to open files with by default";
      default = "code";
      type = lib.types.str;
    };
  };
}
