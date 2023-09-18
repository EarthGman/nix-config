{ pkgs, ... }:
{
  programs = {
    #shell ultilities
    starship.enable = true;
    bat.enable = true;
    htop.enable = true;
    hstr.enable = true;
    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [
        "--cmd" "j"
      ];
    };
    zsh = {
      enable = true;
      enableSyntaxHighlighting = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      shellAliases = {
        nrs = "sudo nixos-rebuild switch --upgrade";
        ncg = "sudo nix-collect-garbage -d";
        nedit = "cd /etc/nixos && code .";
        l = "ls -lh --git -I '.git'";
        ll = "ls -l";
        ls = "eza --icons";
        t = "ls -T -L3";
        ".." = "cd ..";
        "..." = "..;..";
      };
    };
  #system tools
    vscode.enable = true;
    git = {
      enable = true;
      userEmail = "117403037+EarthGman@users.noreply.github.com";
      userName = "EarthGman";
    };
    obs-studio.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    gh = {
        enable = true;
        gitCredentialHelper.enable = true;
    };

  # browsers
    firefox.enable = true;
  };
    
   home.packages = with pkgs; [
    # fonts
    (nerdfonts.override {fonts = ["SourceCodePro"];})
    
    # system tools
    qemu
    sysz
    neofetch
    gnomeExtensions.dash-to-panel

    # gaming
    prismlauncher # minecraft
    grapejuice # roblox
    steam

    # productivity
    obsidian
    gimp
    discord
    libreoffice

    # programming
    github-desktop
    stdenv
    libgcc
    gdb
 ];
}