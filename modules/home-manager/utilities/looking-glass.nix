{ pkgs, ... }:
{
  programs.looking-glass-client = {
    enable = true;
    package = pkgs.looking-glass-client;
    # settings = {
    #   win = {
    #     fullscreen.enable = true;
    #   };
    # };
  };
}
