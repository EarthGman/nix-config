{ pkgs, lib, ... }:
let
  inherit (lib) getExe;
in
{
  programs.fzf = {
    enableZshIntegration = true;
    defaultCommand = "${getExe pkgs.fd} -f";
  };
}
