{ inputs, pkgs, config, lib, hostname, users, timezone, stateVersion, ... }:
{
  imports = [
    inputs.disko.nixosModules.disko
    ./disko.nix
    ./hardware.nix
  ];
  # boot stuff
  boot = {
    kernelParams = [ "quiet" "noatime" ];
    kernelPackages = pkgs.linuxPackages_latest;
    tmp.cleanOnBoot = true;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };

  # network stuff
  networking = {
    networkmanager.enable = true;
    hostName = hostname;
    firewall.allowedTCPPorts = [ 22 ];
  };
  services = {
    sshd.enable = true;
    openssh.enable = true;
    # settings.PasswordAuthentication = false;
  };

  # user
  users = {
    mutableUsers = false;
    users.${users} = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" ];
      hashedPassword = "$y$j9T$h7xkMgTmjL4sZztucHA7T/$cZHZYhWdoyU.x72hX10e4AhBpJzJFX2nGsl1kKgo/i2";
    };
  };

  # misc
  time.timeZone = timezone;
  system.stateVersion = stateVersion;
}
