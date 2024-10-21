{ self, ... }:
let
  profile = self + /profiles/home-manager/bean.nix;
  theme = self + /profiles/home-manager/desktop-themes/faraway.nix;
in
{
  imports = [
    profile
    theme
  ];
}
