{ self, ... }:
let
  theme = self + /profiles/home-manager/desktop-themes/nightmare.nix;
in
{
  imports = [ theme ];
  custom = {
    editor = "codium";
  };

  programs = {
    bottles.enable = true;
    discord.enable = true;
    lutris.enable = true;
    gcolor.enable = true;
  };
}
