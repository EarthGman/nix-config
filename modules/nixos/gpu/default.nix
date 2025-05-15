{ pkgs, lib, ... }@args:
let
  inherit (lib) mkIf;
  gpu = if args ? gpu then args.gpu else null;
in
{
  imports = [
    ./amd.nix
    ./nvidia.nix
    ./intel.nix
  ];

  environment.systemPackages = mkIf (gpu != null) (with pkgs; [
    glxinfo
    libva-utils
    vulkan-tools
    glmark2
  ]);

  modules.gpu.amd.enable = (gpu == "amd");
  modules.gpu.nvidia.enable = (gpu == "nvidia");
  modules.gpu.intel.enable = (gpu == "intel");
}
