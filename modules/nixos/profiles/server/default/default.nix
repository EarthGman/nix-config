{ inputs, outputs, config, modulesPath, lib, system, bios, ... }@args:
let
  server = if args ? server then args.server else false;
  inherit (lib) mkDefault mkEnableOption mkIf;
  cfg = config.profiles.server.default;
  srvos =
    if server then
      [ inputs.srvos.nixosModules.server ]
    else
      [ ];
in
{
  imports = srvos;

  options.profiles.server.default.enable = mkEnableOption "my personal default server profile";

  config = mkIf cfg.enable {

    # debloat
    environment.defaultPackages = [ ];
    #boot.initrd.includeDefaultModules = false;
    hardware.enableRedistributableFirmware = mkDefault false;

    users.users."root" = {
      openssh.authorizedKeys.keys = mkDefault [ outputs.keys.g_pub ];
    };

    # make sure clean doesn't leave any unnecessary nixos configurations
    programs = {
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
