{ self, outputs, lib, hostName, ... }:
let
  extraHM = self + /hosts/${hostName}/users/maliglord/preferences.nix;
in
{
  imports = [
  ] ++ lib.optionals (builtins.pathExists extraHM) [
    extraHM
  ];
}
