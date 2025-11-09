{
  inputs,
  outputs,
  lib,
}:
{
  autoImport = import ./autoImport.nix { inherit lib; };
  mkHost = import ./mkHost.nix { inherit inputs outputs; };
  mkProgramOption = import ./mkProgramOption.nix { inherit lib; };
}
