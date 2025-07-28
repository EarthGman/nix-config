{ lib, ... }:
let
  inherit (lib) autoImport;
  profiles = autoImport ./profiles;
in
{
  imports = [
    ./programs.nix
  ] ++ profiles;
}
