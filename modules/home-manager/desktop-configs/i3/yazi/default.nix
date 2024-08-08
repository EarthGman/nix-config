{ pkgs, lib, ... }:
# not copied ;)
with pkgs.unstable; {

  programs.yazi = {
    enable = true;
    package = yazi;
    enableZshIntegration = true; # adds function "ya"
    settings = import ./settings.nix {
      inherit lib;
      pkgs = pkgs.unstable;
    };
  };
}
