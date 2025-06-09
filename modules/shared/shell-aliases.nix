{ pkgs, lib, config, ... }:
let
  inherit (lib) getExe mkIf;
  cfg = config.programs;
  has-nh = config.programs.nh.enable;
  has-git = config.programs.git.enable;
in
{
  l = "ls -al";
  g = mkIf has-git "${getExe cfg.git.package}";
  t = "${getExe pkgs.tree}";
  lg = mkIf has-git "${getExe cfg.lazygit.package}";
  ga = mkIf has-git "g add .";
  gco = mkIf has-git "g checkout";
  gba = mkIf has-git "g branch -a";
  cat = mkIf (cfg.bat.enable) "${getExe cfg.bat.package}";
  nrs = if (has-nh) then "${getExe cfg.nh.package} os switch $(readlink -f /etc/nixos)" else "sudo nixos-rebuild switch --flake $(readlink -f /etc/nixos)";
  nrt = if (has-nh) then "${getExe cfg.nh.package} os test $(readlink -f /etc/nixos)" else "sudo nixos-rebuild test --flake $(readlink -f /etc/nixos)";
  nrb = "nixos-rebuild build";
  ncg = if (has-nh) then "${getExe cfg.nh.package} clean all" else "sudo nix-collect-garbage -d";
  npu = "nix-prefetch-url";
  npg = "${getExe pkgs.nix-prefetch-git}";
}

