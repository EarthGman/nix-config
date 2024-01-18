# dog dookie desktop environment

# current issues:

# some apps; vscode, nvtop, wine applications, or any steam game do not display desktop icons properly. icon only shows after the app is launched
# the specifically named apps were installed via the nix package manager alongside everything else

# musescore4 only works via flatpak for some reason: "No GSettings schemas are installed on the system" (works in gnome on the same system btw) could affect future programs

{ pkgs, ... }:
{
  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
  };
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  programs.dconf.enable = true;

  # Enable GTK applications to load SVG icons (attempt to fix the icon issue)
  services.xserver.gdk-pixbuf.modulePackages = [ pkgs.librsvg ];


  environment.systemPackages = with pkgs; [
    libsForQt5.breeze-gtk #attempt to fix the icon issue
    libsForQt5.kde-gtk-config #attempt to fix the icon issue
    libsForQt5.kmenuedit # attempt to fix the icon issue
    libsForQt5.qt5.qtsvg # attempt to fix the icon issue
    libsForQt5.kalk # calculator
    libsForQt5.kpmcore # library for partition manager
    partition-manager # KDE partition manager
  ];

  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
  ];
}
