{ gpu, ... }:
let
  amd = (gpu == "amd");
  nvidia = (gpu == "nvidia");
in
{
  imports = [
    ./amd.nix
    ./nvidia.nix
  ];

  modules.gpu.amd.enable = amd;
  modules.gpu.nvidia.enable = nvidia;
}
