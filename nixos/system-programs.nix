{ pkgs, config, ... }:
{
  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
    systemPackages = with pkgs; [
      bat # A cat clone with wings.
      eza # A better ls
      fzf # A command-line fuzzy finder
      git # the stupid content tracker
      hstr # Bash and Zsh shell history suggest box
      htop # interactive process viewer
      neofetch # displays system info
      nix-info # display Nix system information
      ripgrep # a better grep
      sysz # systemd browsing tool
      wget # a network utility to retrieve files from the Web
      qemu_kvm # virtual machines
      nvtop # an htop like monitoring tool for NVIDIA GPUs
      virt-manager # vm manager
      file
      zip
      unzip
    ];
  };

  programs = {
    zsh = {
      enable = true;
      enableBashCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting = {
        enable = true;
        highlighters = [ "main" "brackets" ];
      };
      shellAliases = {
        sudo = "sudo "; # allow for using aliases with sudo
        nrs = "sudo nixos-rebuild switch --upgrade";
        ncg = "sudo nix-collect-garbage -d";
        nedit = "cd /etc/nixos && code .";
        cat = "${pkgs.bat}/bin/bat";
        ls = "eza --icons";
        ld = "l -D";
        ll = "l -lhF";
        la = "l -a";
        t = "l -T -L3";
        l = "ls -lhF --git -I '.git|.DS_'";
        g = "git";
      };
      interactiveShellInit = ''
        eval "$(zoxide init --cmd j zsh)"
        export PATH=$(realpath ~/bin):$PATH
      '';
    };
    starship.enable = true;
    _1password.enable = true;
    _1password-gui.enable = true;
  };
}
