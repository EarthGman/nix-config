# profile designed to trim out unncessary fluff for servers running nixos
{ inputs, outputs, modulesPath, lib, ... }:
{
  imports = [
    ./disko.nix
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
    openssh.authorizedKeys.keys = lib.mkDefault [ outputs.keys.g_pub ];
  };

  # make sure clean doesn't leave any unnecessary nixos configurations
  programs = {
    vim = {
      # srvos assumes im using vim instead of neovim
      enable = false;
      defaultEditor = false;
    };
    nh = {
      clean.extraArgs = "--keep-since 1d --keep 1";
    };
  };

  # use systemd boot, less bloated than grub (plus who needs to theme a server?)
  modules.bootloaders.systemd-boot.enable = true;
  boot = {
    kernelParams = [ "quiet" "noatime" ];
    tmp.cleanOnBoot = true;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };
}
