{
  pkgs,
  lib,
  config,
  ...
}:
{
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
        # gpg."ssh".program = "${pkgs._1password-gui}/bin/op-ssh-sign";
        init.defaultBranch = "main";
      };
    };
  };
}
