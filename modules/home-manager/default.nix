{ inputs, lib, ... }:
{
  imports = lib.autoImport ./. ++ [
    inputs.kriswill.homeModules.kriswill
    inputs.sops-nix.homeManagerModules.sops
    ../shared
  ];
}
