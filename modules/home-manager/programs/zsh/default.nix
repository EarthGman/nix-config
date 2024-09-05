{ pkgs, config, lib, hostName, ... }:
let
  inherit (lib) getExe mkEnableOption mkIf;
in
{
  options.custom.zsh.enable = mkEnableOption "enable home zsh";
  config = {
    programs.zsh = mkIf config.custom.zsh.enable {
      enable = true;
      shellAliases = {
        edit-config = "cd ~/src/nix-config && $EDITOR .";
        edit-preferences = "cd ~/src/nix-config/hosts/${hostName}/users/${config.home.username} && $EDITOR preferences.nix";
      };
      initExtra = ''
        export EDITOR=${config.preferredEditor}
        export PATH=$(realpath ~/bin):$PATH
      '';
    };
    # auto create a .zshrc file with just a comment if no home configuration is specified
    home.file.".zshrc".text = mkIf (!(config.custom.zsh.enable)) "#";
  };
}
    
