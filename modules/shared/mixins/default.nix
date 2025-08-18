{ lib, config, ... }:
{
  imports = lib.autoImport ./.;

  config = lib.mkIf config.gman.enable {
    nixpkgs = {
      config.allowUnfree = lib.mkDefault true;
    };

    meta.profiles = {
      stylix = lib.mkDefault "ashes";
    };

    gman = {
      tmux.enable = true;
    };

    # stuff im sure everyone wants
    programs = {
      ncdu.enable = lib.mkDefault true;
      hstr.enable = lib.mkDefault true;
      neovim.enable = lib.mkDefault true;
      fzf.enable = lib.mkDefault true;
      fd.enable = lib.mkDefault true;
      eza.enable = lib.mkDefault true;
      btop.enable = lib.mkDefault true;
      sysz.enable = lib.mkDefault true;
      yazi.enable = lib.mkDefault true;
      git.enable = lib.mkDefault true;
      lazygit.enable = lib.mkDefault true;
      zsh.enable = lib.mkDefault true;
      bat.enable = lib.mkDefault true;
      starship.enable = lib.mkDefault true;
      tmux.enable = lib.mkDefault true;
    };
  };
}
