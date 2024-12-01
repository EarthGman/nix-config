{ self, config, pkgs, lib, keys, hostName, ... }:
let
  enabled = { enable = lib.mkDefault true; };
  signingkey = keys.k_pub;
  LHmouse = builtins.toFile "lh-mouse.xmodmap" "pointer = 3 2 1";
in
{
  imports = [
    ./essentials.nix
  ];

  custom = {
    fileManager = "yazi";
  };

  programs = {
    git = {
      userName = "Kris Williams";
      userEmail = "115474+kriswill@users.noreply.github.com";
      signing = {
        key = signingkey;
        signByDefault = true;
        gpgPath = "";
      };
      extraConfig = {
        gpg.format = "ssh";
        gpg."ssh".program = "${pkgs._1password-gui}/bin/op-ssh-sign";
      };
    };
  };

  programs.ssh = {
    enable = true;
    forwardAgent = true;
    extraConfig = "IdentityAgent ${config.home.homeDirectory}/.1password/agent.sock";
  };
}
