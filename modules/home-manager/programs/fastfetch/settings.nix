{
  logo = {
    source = "nixos";
  };
  display = {
    separator = " - ";
    color = {
      seperator = "white";
    };
  };
  modules = [
    {
      type = "os";
      key = " OS";
      keyColor = "yellow";
    }
    {
      type = "kernel";
      key = " ├";
      keyColor = "yellow";
    }
    {
      type = "packages";
      key = " ├󰏖";
      keyColor = "yellow";
    }
    {
      type = "shell";
      key = " └";
      keyColor = "yellow";
    }
    {
      type = "wm";
      key = " DE/WM";
      keyColor = "blue";
    }
    {
      type = "lm";
      key = " ├󰧨";
      keyColor = "blue";
    }
    {
      type = "wmtheme";
      key = " ├󰉼";
      keyColor = "blue";
    }
    {
      type = "icons";
      key = " ├󰀻";
      keyColor = "blue";
    }
    {
      type = "terminal";
      key = " ├";
      keyColor = "blue";
    }
    {
      type = "wallpaper";
      key = " └󰸉";
      keyColor = "blue";
    }
    {
      type = "host";
      key = "󰌢 PC";
      keyColor = "green";
    }
    {
      type = "cpu";
      key = " ├󰻠";
      keyColor = "green";
    }
    {
      type = "gpu";
      key = " ├󰍛";
      keyColor = "green";
    }
    {
      type = "disk";
      key = " ├";
      keyColor = "green";
    }
    {
      type = "swap";
      key = " ├󰓡";
      keyColor = "green";
    }
    {
      type = "uptime";
      key = " ├󰅐";
      keyColor = "green";
    }
    {
      type = "display";
      key = " SND";
      keyColor = "cyan";
    }
    {
      type = "player";
      key = " ├󰥠";
      keyColor = "cyan";
    }
    {
      type = "media";
      key = " └󰝚";
      keyColor = "cyan";
    }
    {
      type = "colors";
      paddingLeft = 0;
      symbol = "square";
    }
  ];
}
