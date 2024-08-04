{ self ? null, inputs ? null, outputs ? null, stateVersion ? null, ... }:
let
  helpers = import ./helpers.nix { inherit self inputs outputs stateVersion; };
in
{
  inherit (helpers) mkHome mkHost forAllSystems mapfiles;
}
