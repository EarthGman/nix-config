{
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "regular";
        };
        size = 16;
      };
      window = {
        opacity = 0.87;
        dimensions = {
          columns = 60;
          lines = 20;
        };
      };
    };
  };
}
