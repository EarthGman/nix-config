{ git-username, git-email, ... }:
{
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
