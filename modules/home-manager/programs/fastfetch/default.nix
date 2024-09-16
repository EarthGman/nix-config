{ pkgs, lib, config, ... }:
{
  config = lib.mkIf config.programs.fastfetch.enable {
    programs.fastfetch = {
      settings = import ./settings.nix;
    };
    programs.zsh.shellAliases = {
      ff = "${lib.getExe pkgs.fastfetch}";
    };
  };
}
