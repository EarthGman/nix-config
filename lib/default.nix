{ inputs, outputs }:
{
  mkHost = import ./mkHost.nix { inherit inputs outputs; };
  mkHome = import ./mkHome.nix { inherit inputs outputs; };
}
