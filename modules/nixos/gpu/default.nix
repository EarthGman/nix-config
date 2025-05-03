{ ... }@args:
let
  gpu = if args ? gpu then args.gpu else null;
in
{
  imports = [
    ./amd.nix
    ./nvidia.nix
  ];

  modules.gpu.amd.enable = (gpu == "amd");
  modules.gpu.nvidia.enable = (gpu == "nvidia");
}
