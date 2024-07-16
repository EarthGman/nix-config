{ inputs, pkgs, config, lib, modulesPath, stateVersion, hostname, users, git-username, git-email, ... }:
# UEFI, Q35, Qemu proxmox virtual machine
{
  imports = [
    inputs.home-manager.nixosModules.default
    ./disko.nix
  ];
  # boot stuff
  boot = {
    initrd.availableKernelModules = [ "uhci_hcd" "ehci_pci" "ahci" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" ];
    kernelParams = [ "quiet" "noatime" ];
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

  # user
  users = {
    users.${users} = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" ];
      hashedPassword = "$y$j9T$h7xkMgTmjL4sZztucHA7T/$cZHZYhWdoyU.x72hX10e4AhBpJzJFX2nGsl1kKgo/i2";
    };
  };
  # only used for git pushing (will be removed in a future version once remote building is properly setup)
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
