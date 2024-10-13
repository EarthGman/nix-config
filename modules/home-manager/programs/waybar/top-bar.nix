{
  name = "top";
  layer = "bottom";
  position = "top";
  modules-left = [ "wlr/taskbar" ];

  "wlr/taskbar" = {
    format = "{icon} {title:.17}";
    icon-size = 28;
    spacing = 3;
    on-click-middle = "close";
    on-click = "activate";
    tooltip-format = "{title}";
    ignore-list = [ ];
  };
}
