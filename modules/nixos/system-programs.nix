{ pkgs, config, ... }:
#packages and programs installed on the operating system level
{
  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
    systemPackages = with pkgs; [
      bat # cat with wings
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
      nvtop # an htop like monitoring tool for NVIDIA GPUs
      zoxide
      file
      zip
      unzip
    ];
  };

  programs = {
    _1password.enable = true;
    _1password-gui.enable = true;
  };
}
