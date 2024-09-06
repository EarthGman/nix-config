{ outputs, lib, ... }:
{
  # forces minimal overlay
  nixpkgs.overlays = lib.mkForce [ outputs.overlays.disable-mbrola-voices ];
}
