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
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/g/src/nix-config";
  };
  programs.zsh.enable = true;

  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };
}
