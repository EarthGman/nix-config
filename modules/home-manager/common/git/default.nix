{ git-username, git-email, ... }:
{
  imports = [
    ./github-desktop.nix
    ./lazygit.nix
  ];
  programs = {
    git = {
      enable = true;
      userName = git-username;
      userEmail = git-email;
      #aliases = { };
    };
    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
      settings = {
        version = 1;
      };
    };
  };
}
