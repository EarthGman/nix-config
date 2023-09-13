{ pkgs, ... }:
{
  programs = {
    starship.enable = true;
    bat.enable = true;
    firefox.enable = true;
    htop.enable = true;
    hstr.enable = true;
    git.enable = true;
    vscode.enable = true;
    obs-studio.enable = true;
    

    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [
        "--cmd" "j"
      ];
    };
    zsh = {
      enable = true;
      enableSyntaxHighlighting = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      shellAliases = {
        nrs = "sudo nixos-rebuild switch --upgrade";
        ncg = "sudo nix-collect-garbage -d";
        l = "ls -lh --git -I '.git'";
        ll = "ls -l";
        ls = "eza --icons";
        t = "ls -T -L3";
        ".." = "cd ..";
        "..." = "..;..";
      };
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    gh = {
        enable = true;
        gitCredentialHelper.enable = true;
    };
  };
}