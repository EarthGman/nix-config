{ hostname, lib, ... }:
let
  isServer = builtins.substring 0 7 hostname == "server-";
  isVM = (hostname == "nixos" || isServer);
  isGamingPC = (hostname == "cypher" || hostname == "garth" || hostname == "somnus" || hostname == "cutlass");
  hasSecrets = builtins.pathExists ../../../secrets/${hostname}.yaml;
in
{
  imports = [
    ./environment.nix
    ./1password.nix
    ./systempackages.nix
    ./nix.nix
  ] ++
  (lib.optionals (!isServer) [
    ./xremap.nix
    ./udev.nix
    ./sound.nix
    ./printing.nix
  ]) ++
  (lib.optionals (!isVM) [ ./virtualization.nix ]) ++
  (lib.optionals isGamingPC [ ./steam.nix ]) ++
  (lib.optionals hasSecrets [ ./sops.nix ]);
  users.mutableUsers = lib.mkDefault false;
}
