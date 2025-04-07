# personalized wrapper of modules and options for my PCs with a desktop
{ self, outputs, pkgs, ... }:
{
  imports = with outputs.nixosProfiles; [
    gmans-keymap
    hacker-mode
  ] ++ [
    (self + /profiles/nixos/wg0.nix)
  ];

  modules = {
    android.enable = true;
    zsa-keyboard.enable = true;
    onepassword.enable = true;
    sops.enable = true;
    ledger.enable = true;
  };

  # some extra man pages
  documentation.dev.enable = true;
  environment.systemPackages = with pkgs; [
    man-pages
    man-pages-posix
  ];
}
