# profile designed to trim out unncessary fluff for servers running nixos
{ modulesPath, pkgs, lib, ... }:
let
  inherit (lib) mkDefault;
  ssh-key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKNRHd6NLt4Yd9y5Enu54fJ/a2VCrRgbvfMuom3zn5zg";
in
{
  imports = [
    ./disko.nix
  ];
  # debloat
  disabledModules = [ (modulesPath + "/profiles/all-hardware.nix") ];
  environment.defaultPackages = [ ];
  boot.initrd.includeDefaultModules = false;
  hardware.enableRedistributableFirmware = false;
  documentation = {
    enable = mkDefault false;
    man.enable = mkDefault false;
    doc.enable = mkDefault false;
    info.enable = mkDefault false;
  };
  xdg = {
    icons.enable = false;
    mime.enable = false;
    sounds.enable = false;
  };

  # make sure clean doesn't leave any unnecessary nixos configurations
  programs.nh = {
    clean.extraArgs = "--keep-since 1d --keep 1";
  };

  # use systemd boot, might use UKI later?
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
