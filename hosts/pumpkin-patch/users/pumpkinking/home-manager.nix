{
  stylix.fonts = {
    sizes = {
      applications = 20;
      desktop = 18;
      popups = 18;
      terminal = 20;
    };
  };
  services.kanshi = {
    enable = true;
    settings = [
      # https://gitlab.freedesktop.org/xorg/xserver/-/issues/899
      {
        profile.name = "main";
        profile.outputs = [
          {
            criteria = "DP-3";
            position = "0,0";
            mode = "2560x1440@164.96Hz";
          }
        ];
      }
    ];
  };
}
