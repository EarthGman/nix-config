{
  pkgs,
  lib,
  config,
  icons,
  ...
}:
let
  inherit (lib) getExe;
  kl-script = pkgs.writeScript "knight-launcher.sh" ''
    cd ~/.steam/steam/steamapps/common/Spiral\ Knights
    ${getExe pkgs.steam-run} ${getExe pkgs.jre} -jar ./KnightLauncher.jar
  '';
in
{
  custom = {
    profiles.desktopTheme = "celeste";
  };
  programs = {
    blender.enable = true;
    gnome-text-editor.enable = true;
    steamtinkerlaunch.enable = true;
    r2modman.enable = true;
    bottles.enable = true;
    lutris.enable = true;
    prismlauncher.enable = true;
    discord.enable = true;
    sl.enable = true;
    cbonsai.enable = true;
    cmatrix.enable = true;
    pipes.enable = true;
    museeks.enable = true;
    obs-studio.enable = true;
    totem.enable = true;
  };

  xdg.dataFile."applications/knight-launcher.desktop" = {
    enable = true;
    text = ''
      [Desktop Entry]
      Name=Knight Launcher
      Comment=poorly written 3rd party spiral knights launcher and manager
      Icon=${builtins.fetchurl icons.knight-launcher}
      Exec=${kl-script}
      Type=Application
      Categories=Game
    '';
  };
}
