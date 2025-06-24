{ inputs, config, lib, ... }@args:
let
  server = if args ? server then args.server else false;
  system = if args ? system then args.system else "x86_64-linux";
  inherit (lib) mkDefault mkOverride mkEnableOption mkIf;
  cfg = config.profiles.server.default;
  srvos =
    if server then
      [ inputs.srvos.nixosModules.server ]
    else
      [ ];
in
{
  imports = srvos;

  options.profiles.server.default.enable = mkEnableOption "default server profile";

  config = mkIf cfg.enable {

    # debloat
    environment.defaultPackages = [ ];
    #boot.initrd.includeDefaultModules = false;
    hardware.enableRedistributableFirmware = mkDefault false;

    # make sure clean doesn't leave any unnecessary nixos configurations
    programs = {
      git.enable = mkOverride 800 false;
      lazygit.enable = mkOverride 800 false;
      nh.enable = mkOverride 800 false;
      neovim-custom = {
        package = mkDefault inputs.vim-config.packages.${system}.nvim-lite;
      };
      vim = {
        # srvos assumes im using vim instead of neovim
        enable = false;
        defaultEditor = false;
      };
      nh = {
        clean.extraArgs = "--keep-since 1d --keep 1";
      };
    };

    # use systemd boot, less bloated than grub
    modules.bootloaders.systemd-boot.enable = mkDefault true;
  };
}
