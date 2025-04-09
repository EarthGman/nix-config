{ pkgs, lib, config, ... }:
{
  programs.yazi = {
    package = pkgs.yazi;
    shellWrapperName = "y";
    enableZshIntegration = true;
    settings = import ./settings.nix {
      inherit pkgs lib config;
    };
  };
}
