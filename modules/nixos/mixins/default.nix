{
  pkgs,
  lib,
  config,
  ...
}:
let
  enableProfile =
    profile:
    let
      cfg = config.meta.profiles;
    in
    if (cfg.${profile} != "") then
      {
        ${cfg.${profile}}.enable = true;
      }
    else
      { };

  defaultSession =
    if (config.meta.desktop == "hyprland") then
      "hyprland-uwsm"
    else if (config.meta.desktop == "sway") then
      "sway-uwsm"
    else
      config.meta.desktop;
in
{
  imports = lib.autoImport ./.;

  options.gman.enable = lib.mkEnableOption "EarthGman's default nixos modules";

  config = lib.mkIf config.gman.enable {
    # custom options
    gman = {
      # default mixins
      determinate.enable = lib.mkDefault true;
      nh.enable = lib.mkDefault true;
      zsh.enable = lib.mkDefault true;
      direnv.enable = lib.mkDefault true;

      # enable the profile requested by meta.profiles.${profile}
      profiles = {
        sddm = enableProfile "sddm";
        stylix = enableProfile "stylix";
      };

      # enable mixins based on host metadata
      desktop.enable = (config.meta.desktop != "");
      sops.enable = (config.meta.secretsFile != null);

      # gpu modules
      gpu.intel.enable = (config.meta.gpu == "intel");
      gpu.nvidia.enable = (config.meta.gpu == "nvidia");
      gpu.amd.enable = (config.meta.gpu == "amd");
    };

    # custom core option, but it would be nice to have with stock home-manager
    home-manager.enable = lib.mkDefault true;

    # set profile defaults
    meta.profiles = {
      sddm = lib.mkDefault "astronaut";
    };

    # Stock Nixos options
    # ------------------------------------------------------

    system.stateVersion = config.meta.stateVersion;

    # its not the best anyway
    documentation.nixos.enable = lib.mkDefault false;

    boot = {
      kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
      tmp.cleanOnBoot = lib.mkDefault true;
      kernelParams = [
        "quiet"
        "noatime"
      ];
      loader = {
        efi.canTouchEfiVariables = lib.mkDefault true;
        timeout = lib.mkDefault 10;
      };
    };

    networking = {
      hostName = config.meta.hostname;
      # hardware-configuration.nix has always had this on
      useDHCP = lib.mkDefault true;

      wireless.enable = false;
      networkmanager.enable = lib.mkDefault true;
    };

    users.mutableUsers = lib.mkDefault false;

    nix = {
      channel.enable = lib.mkDefault false;
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        auto-optimise-store = lib.mkDefault true;
      };
    };

    nixpkgs.hostPlatform = config.meta.system;

    hardware.enableRedistributableFirmware = lib.mkDefault (!config.meta.vm);
    hardware.cpu.${config.meta.cpu}.updateMicrocode = lib.mkIf (
      (!config.meta.vm) && (builtins.substring 0 3 config.meta.system) == "x86"
    ) (lib.mkDefault config.hardware.enableRedistributableFirmware);

    environment.systemPackages = builtins.attrValues {
      inherit (pkgs)
        libinput
        ;
    };

    programs = {
      zoxide = {
        enable = lib.mkDefault true;
        flags = lib.mkDefault [
          "--cmd j"
        ];
      };
    };

    services = {
      displayManager = {
        inherit defaultSession;
      };
      openssh.enable = lib.mkDefault true;
      # controversial but necessary for uwsm
      dbus.implementation = lib.mkDefault "broker";
    };
  };
}
