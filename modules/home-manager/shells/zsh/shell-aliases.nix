{ pkgs, username, ... }:
{
  build-iso = "pushd ~/src/nix-config; nix run nixpkgs#nixos-generators -- --format iso --flake .#iso-installer -o result; popd";
  edit-config = "cd ~/src/nix-config && $EDITOR .";
  edit-preferences = "cd ~/src/nix-config/users/${username} && $EDITOR preferences.nix";
  sudo = "sudo ";
  #nrs = "sudo nixos-rebuild switch --flake ~/src/nix-config --upgrade";
  nrs = "${pkgs.nh}/bin/nh os switch ~/src/nix-config";
  #nrt = "sudo nixos-rebuild test --flake ~/src/nix-config";
  nrt = "${pkgs.nh}/bin/nh os test ~/src/nix-config";
  #hms = "home-manager switch --flake ~/src/nix-config; source ~/.zshrc";
  hms = "${pkgs.nh}/bin/nh home switch ~/src/nix-config";
  ncg = "sudo nix-collect-garbage -d";
  cat = "${pkgs.bat}/bin/bat";
  ls = "${pkgs.eza}/bin/eza --icons";
  l = "ls -al";
  g = "${pkgs.git}/bin/git";
  ga = "g add .";
  gco = "g checkout";
  gba = "g branch -a";
}
