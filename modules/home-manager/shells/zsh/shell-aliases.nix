# { pkgs, ... }:
{
  nrs = "sudo nixos-rebuild switch --upgrade";
  hms = "home-manager switch --flake ~/src/nix-config";
  edit-config = "cd ~/src/nix-config && code .";
}