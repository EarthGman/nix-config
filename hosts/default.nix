{ lib, myLib, hostName, ... }:
# main entry point for the nixos system
let
  nixosModules = myLib.autoImport ../modules/nixos;
  hasUser = (builtins.pathExists ./${hostName}/users);
  nixosUsers =
    if hasUser
    then
      myLib.autoImport ./${hostName}/users
    else [ ];
in
{
  imports = lib.optionals (builtins.pathExists ./${hostName}) [
    ./${hostName}
  ]
  ++ nixosModules
  ++ nixosUsers;
}
