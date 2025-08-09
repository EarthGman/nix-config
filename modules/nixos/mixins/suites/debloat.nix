{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.gman.suites.debloat.enable = lib.mkEnableOption "gman's nixos debloater";

  config = lib.mkIf config.gman.suites.debloat.enable {
    hardware.enableRedistributableFirmware = lib.mkOverride 800 false;

    home-manager.enable = lib.mkOverride 800 false;

    environment = {
      defaultPackages = [ ];
      variables.BROWSER = "echo";
      stub-ld.enable = lib.mkDefault false;
    };

    xdg = {
      autostart.enable = lib.mkDefault false;
      icons.enable = lib.mkDefault false;
      menus.enable = lib.mkDefault false;
      mime.enable = lib.mkDefault false;
      sounds.enable = lib.mkDefault false;
    };

    documentation = {
      enable = lib.mkDefault false;
      doc.enable = lib.mkDefault false;
      info.enable = lib.mkDefault false;
      man.enable = lib.mkDefault false;
      nixos.enable = lib.mkDefault false;
    };

    fonts.fontconfig.enable = lib.mkDefault false;

    programs = {
      git.package = lib.mkDefault pkgs.gitMinimal;
      command-not-found.enable = lib.mkDefault false;

      # lighter custom neovim with no lspconfig (only relevent if its enabled)
      neovim-custom.package = lib.mkDefault pkgs.nvim-lite;
    };
  };
}
