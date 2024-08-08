{ pkgs, lib, config, ... }:
# not copied ;)
with pkgs.unstable; {
  options.yazi.enable = lib.mkEnableOption "yazi";
  config = lib.mkIf config.yazi.enable {
    programs.yazi = {
      enable = true;
      package = yazi;
      enableZshIntegration = true; # adds function "ya"
      settings = import ./settings.nix {
        inherit lib;
        pkgs = pkgs.unstable;
      };
    };
  };
}
