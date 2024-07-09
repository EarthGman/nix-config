{ shell, lib, ... }:
{
  imports = lib.optionals (shell == "zsh") [
    ./zsh
  ];

  programs = {
    starship = {
      enable = true;
      enableZshIntegration = (shell == "zsh");
    };
    zoxide = {
      enable = true;
      enableZshIntegration = (shell == "zsh");
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
