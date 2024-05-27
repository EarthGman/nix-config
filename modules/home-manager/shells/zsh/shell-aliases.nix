# { pkgs, ... }:
{
  nrs = "sudo nixos-rebuild switch --upgrade";
  nrt = "sudo nixos-rebuild test";
  hms = "home-manager switch --flake ~/src/nix-config";
  ncg = "sudo nix-collect-garbage -d";
  edit-config = "cd ~/src/nix-config && $EDITOR .";
}
