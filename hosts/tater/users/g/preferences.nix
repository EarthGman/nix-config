{ ... }:
{
  profiles.laptop.enable = true;
  profiles.smallscreen.enable = true;

  programs = {
    moonlight.enable = true;
    ghidra.enable = true;
    bottles.enable = false;
    ardour.enable = false;
    rpi-imager.enable = true;
  };

  services.polybar.settings = {
    "bar/bottom" = {
      height = "16pt";
      font-0 = "MesloLGS Nerd Font Mono:size=12;4";
      modules-left = "wlan cpu memory";
    };
  };
}
