{ hostname, lib, ... }:
let
  notVM = if (hostname != "nixos") then true else false;
in
{
  imports = [
    ./zsh.nix
    ./1password.nix
    ./systempackages.nix
    ./nix.nix
    ./sound.nix
    ./printing.nix
    ./xremap.nix
  ] ++ (lib.optionals notVM [
    ./virtualization.nix
  ]);
}
