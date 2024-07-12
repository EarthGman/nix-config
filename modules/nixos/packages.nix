{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nix-output-monitor
    bcachefs-tools
    cryptsetup
    git
    disko
    ripgrep
    gparted
    wget
    file
    zip
    unzip
    sops
    age
  ];
  programs.zsh.enable = true;
}
