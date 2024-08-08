{ gpu, lib, pkgs, hostname, ... }:
let
  amd = (gpu == "amd");
  nvidia = (gpu == "nvidia");
  isLaptop = (hostname == "cutlass");
in
{
  imports =
    (lib.optionals amd [ ./amd.nix ]) ++
    (lib.optionals nvidia [ ./nvidia.nix ]) ++
    (lib.optionals isLaptop [ ./prime.nix ]);
  environment.systemPackages = [ pkgs.glxinfo ];
}
