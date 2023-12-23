{pkgs, ...}:
{
  home.packages = with pkgs; [
    gnomeExtensions.dash-to-panel
  ];
}
