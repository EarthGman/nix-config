{ self, outputs, hostName, lib, ... }:
let
  enabled = { enable = lib.mkDefault true; };
in
{
  imports = [
    (self + /hosts/${hostName}/users/bean/preferences.nix)
    outputs.homeProfiles.essentials
  ];
  # custom = {
  #   editor = "codium";
  # };

  programs = {
    git = {
      userName = "ThunderBean290";
      userEmail = "156272091+Thunderbean290@users.noreply.github.com";
    };
    filezilla = enabled;
    gcolor = enabled;
    obs-studio = enabled;

    zsh.shellAliases = {
      edit-config = "cd ~/src/nix-config && $EDITOR .";
    };
  };
}
