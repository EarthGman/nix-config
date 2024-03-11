{ pkgs, ... }:
{
  home.packages = with pkgs; [
    github-desktop
  ];
  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
    settings = {
      # Workaround for https://github.com/nix-community/home-manager/issues/4744
      version = 1;
    };
  };
}
