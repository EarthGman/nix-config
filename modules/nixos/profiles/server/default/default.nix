{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (lib)
    mkDefault
    mkOverride
    mkEnableOption
    mkIf
    ;
  cfg = config.profiles.server.default;
in
{
  options.profiles.server.default.enable = mkEnableOption "default server profile";
  # srvos module is imported using lib.mkHost for debloat
  # https://github.com/nix-community/srvos
  config = mkIf cfg.enable {
    # debloat
    environment.defaultPackages = [ ];
    # by default remove linux firmwares as they aren't normally needed by vms or containers
    hardware.enableRedistributableFirmware = mkDefault false;

    services.openssh = {
      enable = mkDefault true;
      # ensure that password authentication is disabled by default
      settings = {
        PasswordAuthentication = mkDefault false;
        KbdInteractiveAuthentication = mkDefault false;
      };
    };

    programs = {
      # disable nh as it has gotten fairly buggy lately and I just update servers using ssh anyway
      nh.enable = mkOverride 800 false;
      neovim-custom = {
        # use a smaller neovim with no lsps clogging the hard drive
        package = pkgs.nvim-lite;
      };
      # srvos server module automatically enables vim, just ensure that its disabled in favor of neovim
      vim = {
        enable = false;
        defaultEditor = false;
      };
    };

    # use systemd boot as opposed to grub
    modules.bootloaders = {
      systemd-boot.enable = mkDefault true;
      grub.enable = false;
    };
  };
}
