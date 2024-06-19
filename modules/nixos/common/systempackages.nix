{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nix-output-monitor
    bcachefs-tools
    cryptsetup
    git
    gparted
    wget
    file
    zip
    unzip
    sops
    age
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
