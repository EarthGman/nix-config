{ hostname, lib, ... }:
let
  notVM = (hostname != "nixos");
  isGamingPC = (hostname == "cypher" || hostname == "garth" || hostname == "somnus" || hostname == "cutlass");
  hasSecrets = builtins.pathExists ../../../secrets/${hostname}.yaml;
in
{
  imports = [
    ./environment.nix
    ./1password.nix
    ./systempackages.nix
    ./nix.nix
    ./sound.nix
    ./printing.nix
    ./xremap.nix
    ./udev.nix
  ] ++
  (lib.optionals notVM [ ./virtualization.nix ]) ++
  (lib.optionals isGamingPC [ ./steam.nix ]) ++
  (lib.optionals hasSecrets [ ./sops.nix ]);
  users.mutableUsers = lib.mkDefault false;
}
