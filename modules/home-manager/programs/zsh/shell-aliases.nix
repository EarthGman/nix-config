{ pkgs, username, hostname, ... }:
{
  edit-config = "cd ~/src/nix-config && $EDITOR .";
  edit-preferences = "cd ~/src/nix-config/hosts/${hostname}/users/${username} && $EDITOR preferences.nix";
  nix-shell = "nix-shell --command zsh";
  nixdev = "nix develop --command zsh";
  sudo = "sudo ";
  nrs = "${pkgs.nh}/bin/nh os switch ~/src/nix-config";
  nrt = "${pkgs.nh}/bin/nh os test ~/src/nix-config";
  hms = "${pkgs.nh}/bin/nh home switch ~/src/nix-config";
  ncg = "${pkgs.nh}/bin/nh clean all";
  cat = "${pkgs.bat}/bin/bat";
  ls = "${pkgs.eza}/bin/eza --icons";
  l = "ls -al";
  g = "${pkgs.git}/bin/git";
  t = "${pkgs.tree}/bin/tree";
  ff = "${pkgs.fastfetch}/bin/fastfetch";
  ga = "g add .";
  gco = "g checkout";
  gba = "g branch -a";
}