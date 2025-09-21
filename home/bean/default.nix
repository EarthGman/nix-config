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
      signing = {
        key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKbonyjuIdQxAJ788rfATPHOpc7KLTB9Z64z9r/V7a9N";
        signByDefault = true;
      };
      extraConfig = {
        gpg.format = "ssh";
      };
    };
    neovim-custom = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
  };
}
