{ config, pkgs, lib, ... }:
let
  inherit (lib) getExe mkDefault;
in
{
  programs.fzf = {
    enableZshIntegration = true;
    defaultCommand = "${getExe pkgs.fd} -f";
  };
  programs.fd = {
    enable = mkDefault config.programs.fzf.enable;
    ignores = [
      ".git/"
      ".bak"
      ".direnv/"
    ];
  };
}
