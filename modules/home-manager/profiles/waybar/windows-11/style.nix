{ config, ... }:
let
  desktop-fontsize = toString config.stylix.fonts.sizes.desktop;
in
''
  #window, #network, #cpu, #memory, #disk, #pulseaudio,
  #custom-microphone, #custom-notifications, #custom-settings-menu,
  #sway-workspaces, #hyprland-workspaces,
  #battery, #clock, #tray, #temperature {
    font-size: ${desktop-fontsize};
    background-color: #303030;
    color: #cecece;
    border-radius: 5px;
    padding-left: 10px;
    padding-right: 10px;
    margin: 5px;
  }

  #custom-settings-menu {
    font-size: ${desktop-fontsize};
    background-color: #303030;
    color: #cecece;
    border-radius: 5px;
    padding-left: 10px;
    padding-right: 12px;
    margin: 5px;
  }

  #tray {
    padding: 0 10px;
  }

  #custom-os_button {
    color: #85cffa;
  }

  .modules-left #workspaces button {
    border-bottom: 3px solid transparent;
  }
  .modules-left #workspaces button.focused,
  .modules-left #workspaces button.active {
    border-bottom: 3px solid @base05;
  }
    .modules-center #workspaces button {
    border-bottom: 3px solid transparent;
  }
  .modules-center #workspaces button.focused,
  .modules-center #workspaces button.active {
    border-bottom: 3px solid @base05;
  }
  .modules-right #workspaces button {
    border-bottom: 3px solid transparent;
  }
  .modules-right #workspaces button.focused,
  .modules-right #workspaces button.active {
    border-bottom: 3px solid @base05;
  }
''
