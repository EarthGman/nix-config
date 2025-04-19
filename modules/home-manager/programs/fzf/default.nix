{ pkgs, lib, config, ... }:
let
  inherit (lib) getExe;
in
{
  programs.fzf = {
    enableZshIntegration = true;
    defaultCommand = "${getExe config.programs.fd.package} -f";
  };
}
