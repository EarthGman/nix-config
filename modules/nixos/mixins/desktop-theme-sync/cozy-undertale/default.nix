{ pkgs, ... }:
{
  gman.profiles.sddm.astronaut.config.themeConfig = {
    Background = pkgs.images.mt-ebott;
  };
}
