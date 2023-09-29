{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    eza
  ];

  programs = {
    zsh = {
      enable = true;
      enableBashCompletion = true;
      autosuggestions.enable = true;
      shellAliases = {
        ls = "eza --icons";
        ld = "l -D";
        ll = "l -lhF";
        la = "l -a";
        t = "l -T -L3";
        l = "ls -lhF --git -I '.git|.DS_'";
        sudo = "sudo "; # allow for using aliases with sudo
        nrs = "sudo nixos-rebuild switch --upgrade";
        g = "git";
        nedit = "cd /etc/nixos && code .";
      };
      interactiveShellInit = ''
        eval "$(zoxide init --cmd j zsh)"
      '';
    };
    starship.enable = true;
    _1password.enable = true;
    _1password-gui.enable = true;
  };
}
