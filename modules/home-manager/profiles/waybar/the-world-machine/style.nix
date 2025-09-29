{ config, ... }:
let
  small = config.gman.smallscreen.enable;
  font-size-default =
    if small then
      toString config.stylix.fonts.sizes.desktop
    else
      toString (config.stylix.fonts.sizes.desktop + 4);

  font-size-text-modules =
    if small then
      toString (config.stylix.fonts.sizes.desktop + 2)
    else
      toString (config.stylix.fonts.sizes.desktop + 8);

  module-padding = if small then "7px" else "10px";
in
''
  @define-color text #9564FD;
  @define-color activeWorkspace #9564FD;
  @define-color hoverWorkspace #7f849c;
  @define-color background #000000;

  * {
    font-family: "${config.stylix.fonts.monospace.name}";
    font-weight: bold;
    font-size: ${font-size-default}px;
  }

  window#waybar {
    background: @background;
    border: 0 solid @text;
    border-top-width: 4px;
  }

  #image {
    margin: 8px 12px 6px;
  }

  #custom-powermenu {
    color: @text;
  }

  #clock,#battery, #pulseaudio, #custom-microphone {
    font-size: ${font-size-text-modules}px;
    color: @text;
    border-radius: 5px;
    padding-left: ${module-padding};
    padding-right: ${module-padding};
    margin: 5px;
  }

  #tray {
    padding: 0 10px;
    font-size: ${toString (config.stylix.fonts.sizes.desktop)}px;
    background-color: @background;
    border-radius: 5px;
    margin: 5px;
  }

  #taskbar button {
    padding: 0px 10px;
    margin: 8px 4px 4px;
  }

  #taskbar button.active {
    color: @background;
    background-color: @text;
    border-radius: 30px;
  }

  .modules-center #workspaces button.focused,
  .modules-center #workspaces button.active {
    border-bottom: 3px solid @text;
  }
''
