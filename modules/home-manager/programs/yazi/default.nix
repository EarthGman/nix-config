{ pkgs, lib, config, ... }:
# not copied ;)
{
  options.custom.yazi.enable = lib.mkEnableOption "yazi";
  config = lib.mkIf config.custom.yazi.enable {
    programs.yazi = {
      enable = true;
      package = pkgs.yazi;
      enableZshIntegration = true; # adds function "ya"
      settings = import ./settings.nix {
        inherit pkgs lib;
      };
      keymap = import ./keymap.nix { inherit pkgs; };
    };
  };
}
