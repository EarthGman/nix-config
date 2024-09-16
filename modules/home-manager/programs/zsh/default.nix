{ pkgs, config, lib, hostName, ... }:
let
  inherit (lib) getExe mkIf;
  cfg = config.programs.zsh;
in
{
  config = {
    programs.zsh = mkIf cfg.enable {
      shellAliases = {
        l = "${getExe pkgs.eza} -al --icons";
        ls = "${getExe pkgs.eza} --icons";
        edit-config = "cd ~/src/nix-config && $EDITOR .";
        edit-preferences = "cd ~/src/nix-config/hosts/${hostName}/users/${config.home.username} && $EDITOR preferences.nix";
      };
      initExtra = ''
        export EDITOR=${config.custom.preferredEditor}
        export PATH=$(realpath ~/bin):$PATH
      '';
    };
    # auto create a .zshrc file with just a comment if no home configuration is specified
    home.file.".zshrc".text = mkIf (!(cfg.enable)) "#";
  };
}
    
