{ pkgs, username, ... }:
{
  edit-config = "cd ~/src/nix-config && $EDITOR .";
  edit-preferences = "cd ~/src/nix-config/users/${username} && $EDITOR preferences.nix";
  sudo = "sudo ";
  nrs = "${pkgs.nh}/bin/nh os switch ~/src/nix-config";
  nrt = "${pkgs.nh}/bin/nh os test ~/src/nix-config";
  hms = "${pkgs.nh}/bin/nh home switch ~/src/nix-config";
  ncg = "sudo nix-collect-garbage -d";
  cat = "${pkgs.bat}/bin/bat";
  ls = "${pkgs.eza}/bin/eza --icons";
  l = "ls -al";
  g = "${pkgs.git}/bin/git";
  t = "${pkgs.tree}/bin/tree";
  ga = "g add .";
  gco = "g checkout";
  gba = "g branch -a";
}
