{ inputs, lib, ... }:
{
  imports = lib.autoImport ./. ++ [
    inputs.sops-nix.homeManagerModules.sops
    ../shared
  ];
}
