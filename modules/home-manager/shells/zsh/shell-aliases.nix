{ pkgs, username, ... }:
{
  build-iso = "pushd ~/src/nix-config; nix run nixpkgs#nixos-generators -- --format iso --flake .#iso-installer -o result; popd";
  edit-config = "cd ~/src/nix-config && $EDITOR .";
  edit-preferences = "cd ~/src/nix-config/users/${username} && $EDITOR preferences.nix";
  sudo = "sudo ";
  nrs = "sudo nixos-rebuild switch --upgrade";
  nrt = "sudo nixos-rebuild test";
  hms = "home-manager switch --flake ~/src/nix-config; source ~/.zshrc";
  ncg = "sudo nix-collect-garbage -d";
  cat = "${pkgs.bat}/bin/bat";
  ls = "${pkgs.eza}/bin/eza --icons";
  l = "ls -al";
  g = "${pkgs.git}/bin/git";
  ga = "g add .";
  gco = "g checkout";
  gba = "g branch -a";
}
