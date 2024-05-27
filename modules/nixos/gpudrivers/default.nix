{ gpu, hostname, ... }:
let
  amd = if (gpu == "amd") then true else false;
  nvidia = if (gpu == "nvidia") then true else false;
  isLaptop = if (hostname == "cutlass") then true else false;
in
{
  imports =
    (lib.optionals amd [ ./amd.nix ]) ++
    (lib.optionals nvidia [ ./nvidia.nix ]) ++
    (lib.optionals isLaptop [ ./prime.nix ]);
}
