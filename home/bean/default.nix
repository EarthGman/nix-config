{ hostname, ... }:
let
  extraHM = ../../hosts/${hostname}/users/bean/home-manager.nix;
in
{
  imports = if (builtins.pathExists extraHM) then [ extraHM ] else [ ];

  meta.profiles.firefox = "shyfox";

  programs = {
    git = {
      userName = "ThunderBean290";
      userEmail = "156272091+Thunderbean290@users.noreply.github.com";
    };
    neovim-custom = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
  };
}
