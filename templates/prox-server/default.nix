{ inputs, pkgs, config, lib, hostname, users, git-username, git-email, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.default
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
  };

  environment.systemPackages = with pkgs; [
    sysz
  ];

  # user
  users = {
    users.${users} = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" ];
      hashedPassword = "$y$j9T$h7xkMgTmjL4sZztucHA7T/$cZHZYhWdoyU.x72hX10e4AhBpJzJFX2nGsl1kKgo/i2";
    };
  };
  # only used for git pushing
  home-manager = {
    users = {
      "${users}" = {
        home = {
          username = users;
          inherit stateVersion;
          homeDirectory = "/home/${users}";
        };
        programs = {
          home-manager.enable = true;
          git = {
            enable = true;
            userName = git-username;
            userEmail = git-email;
          };
        };
      };
    };
  };
}
