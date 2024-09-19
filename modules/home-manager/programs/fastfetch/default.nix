{ pkgs, lib, config, ... }:
let
  cfg = config.programs.fastfetch;
in
{
  options.programs.fastfetch = {
    image = lib.mkOption {
      description = "image used for fastfetch";
      type = lib.types.str;
      default = "nixos";
    };
  };
  config = lib.mkIf cfg.enable {
    programs.fastfetch = {
      settings = import ./settings.nix { inherit config; };
    };
    programs.zsh.shellAliases = {
      ff = "${lib.getExe pkgs.fastfetch}";
    };
  };
}
