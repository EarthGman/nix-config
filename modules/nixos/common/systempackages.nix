{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bcachefs-tools
    cryptsetup
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
  };
  programs.zsh.enable = true;

  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };
}
