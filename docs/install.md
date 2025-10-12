- The installer will provide a script to guide users through the installation process. It can be invoked using `sudo install.sh`

- NixOS requires a network connection to install. This is because software in the configuration is not compiled into the iso image. The script will check to ensure you have a network connection and will run `nmtui` if none is found.

- Advanced users may opt to run the script through a tmux session for various tasks such as the placement of key files. Note that the default tmux bind is ctrl+space not ctrl+b. This can be changed before compiling the iso.

**For reference, any directory path will refer to the root of the repository being created NOT the root filesystem. During install this will be located under /mnt/etc/nixos**

# Installation

There are 3 options available, pick one:

## 1. Creating a new configuration repository

Creates a brand new repository structured with a flake and the configuration for the current system.

## 2. Appending to an existing repository

Appends a new host configuration to an existing flake repository under `/hosts`

## 3. Installing or repairing an existing configuration.

Used for reinstallation or repair if a system cannot be rolled back.

> NOTE: If pulling a private repository ensure the installer has access to your git repository via account login or ssh private key.

# Formatting disks

When formatting disks, the installer will identify which mode of installation you are using.

For method 1, the target disk will be formatted with 2 partitions "boot" with FAT32 and "root" with ext4. If you wish to use a different layout (such as a seperate home partition) you will have to partition it yourself using fdisk or parted and return to the installer once finished.

For the other 2 methods, you will be given the option to use a disko.nix file from your existing repository.

For context, [disko](https://github.com/nix-community/disko) is a utility that allows for declarative disk specification using nix files and provides several templates in the repository.
It also provides a nix module that will add the specified disk layout to the NixOS option "fileSystems" for /etc/fstab configuration.

**All root filesystems must be mounted under /mnt before the installation begins. Both Disko, and the script will automatically mount the required filesystems unless you manually partitioned the disks using fdisk.**

-------------------------------------------------------------

# Hardware specifications

A major complication with NixOS arises from differences in hardware. An identical configuration may work on one machine but not another.

There are several projects worth looking into for getting around this issue such as [NixOS Hardware](https://github.com/nixos/nixos-hardware) and [NixOS Factor](https://github.com/nix-community/nixos-facter)

These are worth checking out after installation has completed, but by default, the installer will use the built-in nixos-generate-config to load kernel modules, NixOS profiles, and specify your fstab.

The file "hardware-configuration.nix" will be placed in the config folder for your host. It should not be modified unless your hardware configuration changes (such as getting a new disk or cpu).
To apply these changes safely, reboot the installer and reinstall the existing config.

Unfortunately this generated file will not provide configuration for some hardware on your system such as GPU drivers from nvidia or amd.

However, I have included many NixOS modules to attempt to cover most of these bases using a custom nix funciton.

-------------------------------------------------------------

# lib.mkHost

Is not a function from nixpkgs. Rather, it is a custom wrapper function I wrote for lib.nixosSystem to provide an overview of a system's current configuration.

Hardware and other specifications will be detected by the installer and passed to this function to trigger custom modules throughout the config (such as installing nvidia or amdgpu drivers, or setting up a desktop environment).

The installer will generate /hosts/default.nix with the call to this function.

an example of my main workstation looks like this:

```
cypher = lib.mkHost {
    hostname = "cypher";
    cpu = "amd";
    gpu = "amd";
    users = [ "g" ];
    desktop = "sway";
    system = "x86_64-linux";
    stateVersion = "25.11";
    configDir = ./cypher;
    extraSpecialArgs = { inherit inputs; };
    secretsFile = ./cypher/secrets.yaml;
  };
```

--------------------------------------------------------------

# Home Manager

Is a set of nix modules designed for the managment of user packages and dotfiles within a particular home directory.

Any non-root users created via the install script will automatically have a home-manager configuration generated for them.

Configuration files for home-manager are /home/username/default.nix and /hosts/hostname/users/username/home-manager.nix.

/home/$username/default.nix will provide a universal configuration for all users with that username across all systems.
This is where you want to place configuration for your git account, keys, or software you plan to use across all systems.

/hosts/hostname/users/username/home-manager.nix defines home-manager configuration specific to that user on that host (such as monitor configuration).

By default, the installer will integrate home-manager's modules into NixOS, allowing the system to rebuild as one unit.

--------------------------------------------------------------

# Sops Nix

[Sops Nix](https://github.com/Mic92/sops-nix) is a tool and module set for nix that allows secrets such as user password hashes or private ssh keys to be securely stored in your nix configuration repository as encrypted files.

Many NixOS modules allow for the specification of a secret using a string of text. This is always insecure even if the configuration repository cannot be viewed by other users on the system.

The reason for this is that nix will copy a world-readable version of your configuration repository to the /nix/store which can be inspected to extract the secret.

To work around this, nix modules often provide a secretFile option such as `users.users.username.hashedPasswordFile` to direct the configuration to a decrypted sops file (which is not world readable).

By default, the installer does not have automatic sops setup and will have to be configured after the install has completed. (Will be added at a later date)

However, for installing an existing configuration with secrets enabled, the installer will allow you to place your private key file at the configured location on the filesystem before you continue.
