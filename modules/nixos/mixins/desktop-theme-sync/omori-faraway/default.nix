{ pkgs, ... }:
{
  gman.profiles.sddm.astronaut.config.themeConfig = {
    Background = pkgs.images.omori-gang-5;
  };
}
