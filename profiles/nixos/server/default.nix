# Virtual Machine, for lxc use mkLXC instead of mkHost
{ inputs, outputs, modulesPath, lib, system, bios, ... }:
let
  inherit (lib) mkDefault;
in
{
  imports = [
    # pretty cool repo for servers
    inputs.srvos.nixosModules.server
  ];

  time.timeZone = "America/Chicago"; # srvos wanted me to use UTC

  # debloat
  disabledModules = [ (modulesPath + "/profiles/all-hardware.nix") ];
  environment.defaultPackages = [ ];
  #boot.initrd.includeDefaultModules = false;
  hardware.enableRedistributableFirmware = false;

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
  modules.bootloaders.systemd-boot.enable = true;
  boot = {
    kernelParams = [ "quiet" "noatime" ];
    tmp.cleanOnBoot = true;
    loader = {
      efi.canTouchEfiVariables = mkDefault (bios == "UEFI");
      systemd-boot.enable = true;
    };
  };
}
