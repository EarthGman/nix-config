{ outputs, ... }:
let
  theme = outputs.homeProfiles.desktopThemes.nightmare;
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
