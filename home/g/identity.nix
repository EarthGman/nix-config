{
  pkgs,
  lib,
  config,
  ...
}:
{
  services.gpg-agent = {
    # this module does not exist in home-manager. I made it myself according to the pam gnupg repository
    # https://github.com/cruegge/pam-gnupg
    pam = {
      enable = true;
      keygrips = [
        "FB7332E3DAFAF1E1EE033BF1E2FB0C0257F90FF5" # pass
        "2586B10492113ADF1A15E83CF85DFF5FA8162BEE" # ssh
      ];
    };
  };
  programs = {
    git = {
      userName = "EarthGman";
      userEmail = "EarthGman@protonmail.com";
      signing = {
        key = config.gman.ssh-keys.g;
        signByDefault = true;
        signer = "";
      };
      extraConfig = {
        gpg.format = "ssh";
        init.defaultBranch = "main";
      };
    };
  };
}
