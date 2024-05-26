{
  imports = [
    ./excluded-pkgs.nix
  ];
  services.xserver.desktopManager.gnome.enable = true;
  programs.dconf.enable = true;
  qt.enable = true;
}
