{ pkgs, ... }:
{
  sudo = "sudo "; # allow for using aliases with sudo
  nrs = "sudo nixos-rebuild switch --upgrade";
  hms = "NIXPKGS_ALLOW_UNFREE=1 home-manager switch --impure --flake ~/src/nix-config";
  ncg = "sudo nix-collect-garbage -d";
  nedit = "cd /home/g/src/nix-config && code .";
  cat = "${pkgs.bat}/bin/bat";
  ls = "${pkgs.eza}/bin/eza --icons";
  ld = "l -D";
  ll = "l -lhF";
  la = "l -a";
  t = "l -T -L3";
  l = "ls -lhF --git -I '.git|.DS_'";
  g = "${pkgs.git}/bin/git";
  gco = "g checkout";
  gba = "g branch -a";
}
