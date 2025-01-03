{ pkgs, lib, config, ... }:
# not copied ;)
{
  programs.yazi = {
    package = pkgs.yazi;
    shellWrapperName = "y";
    enableZshIntegration = true; # adds function "yy"
    settings = import ./settings.nix {
      inherit pkgs lib config;
    };
    keymap = import ./keymap.nix { inherit pkgs; };
  };
}
