{ pkgs, lib, config, ... }:
# not copied ;)
{
  programs.yazi = {
    package = pkgs.yazi;
    # enableZshIntegration = true; # adds function "ya"
    settings = import ./settings.nix {
      inherit pkgs lib;
    };
    keymap = import ./keymap.nix { inherit pkgs; };
  };
  # for some reason enableZshIntegation stopped working
  programs.zsh.shellAliases = lib.mkIf config.programs.zsh.enable {
    ya = "${lib.getExe pkgs.yazi}";
  };
}
