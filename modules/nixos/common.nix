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
      nix-info # display Nix system information
      ripgrep # a better grep
      sysz # systemd browsing tool
      wget # a network utility to retrieve files from the Web
      zoxide # allows user to jump directly to a directory
      file
      zip # archiver
      unzip # archive unzipper
      lshw
      tree # command to list files as a tree
      radeontop # another htop like monitoring tool for AMD GPUs only
      nvtop # an htop like monitoring tool for GPUs
      powertop # power consumption monitoring tool
      nix-prefetch-git # for obtaining github hashes
      ncdu
      jq
      dua
      openssl
      usbutils
      pciutils
    ];
  };

  programs = {
    _1password.enable = true;
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = [ "g" ];
    };
  };
}
