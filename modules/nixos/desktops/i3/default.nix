{
  services.xserver.windowManager.i3 = {
    enable = true;
    extraSessionCommands = ''
      export XDG_CURRENT_DESKTOP=i3
      export XDG_SESSION_DESKTOP=i3
    '';
  };
}
