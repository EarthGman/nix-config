{ self, outputs, lib, hostName, ... }:
let
  extraHM = self + /hosts/${hostName}/users/maliglord/preferences.nix;
in
{
  imports = [
    (outputs.homeProfiles.essentials)
  ] ++ lib.optionals (builtins.pathExists extraHM) [
    extraHM
  ];
}
