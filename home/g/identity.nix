{
  pkgs,
  lib,
  config,
  ...
}:
{
  services.gpg-agent = {
    pam = {
      enable = true;
      keygrips = [
        "FB7332E3DAFAF1E1EE033BF1E2FB0C0257F90FF5"
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
