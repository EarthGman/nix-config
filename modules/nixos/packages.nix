{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nix-output-monitor
    bcachefs-tools
    cryptsetup
    git
    disko
    ripgrep
    wget
    file
    zip
    unzip
    sops
    age
    sysz
    lshw
  ];
  programs = {
    zsh = lib.mkDefault {
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      enable = true;
      shellAliases = {
        l = "ls -al";
        g = "${pkgs.git}/bin/git";
        t = "${pkgs.tree}/bin/tree";
        ga = "g add .";
        gco = "g checkout";
        gba = "g branch -a";
        cat = "${pkgs.bat}/bin/bat";
      };
    };
    starship = {
      enable = true;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
