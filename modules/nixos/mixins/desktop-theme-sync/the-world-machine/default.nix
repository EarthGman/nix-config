{ pkgs, ... }:
{
  gman.profiles.sddm.astronaut.config.themeConfig = {
    Background = pkgs.images.the-world-machine;
    FormPosition = "left";
  };
}
