{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git
    gparted
    wget
    file
    zip
    unzip
  ];

  programs.zsh.enable = true;

  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };
}
