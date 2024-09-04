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

  custom.amdgpu.enable = amd;
  custom.nvidiagpu.enable = nvidia;
}
