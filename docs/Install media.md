------------------------------------------------------------------------

If you enjoy NixOS and want to install it on several machines, I would recommend creating your own bootable iso image with tools you want accessible.

Start by creating a new nixosConfiguration using mkHost and set the iso flag to true

```
nixos-installer = mkHost {
    hostName = "nixos-installer";
    iso = true;
    system = "x86_64-linux";
    configDir = ./hosts/nixos-installer;
};
```

Now set configuration options in your hosts/nixos-installer to include all the tools your want to add. This can include various tools such as sysz, yazi, git, cryptsetup, and disko.

It is possible to add a desktop flag such as 'desktop = "gnome"' for a graphical install.

Once the host is configured you now need to build the image.
install nixos-generators on the host you want to build from.

```nix
environment.systemPackages = [ pkgs.nixos-generators ];
```

Now you can run

```
nixos-generate --flake /etc/nixos#nixos-installer -f iso -o result
```

The installation image will appear in result/ created within the directory you ran the command from.

you can then copy the file outside of the nix store and store it wherever you want.

next insert the installation disk and use dd to flash the iso

```
sudo dd bs=4M if=./nixos-installer.iso of=/dev/sdX status=progress oflag=sync
```

------------------------------------------------------------------------

Once you load into the installer you will be a "nixos" user. The password to this user is set to "123" as it is needed for an ssh connection.

you will need to imperatively partition the disks. I personally use disko to semi-automate this process: https://github.com/nix-community/disko

The minimal setup is a boot partition for systemd-boot or grub, I typically make mine 256M, and a root partition.

If choosing to manually partition via fdisk or similar, mount the root partition on /mnt and run ```

```
nixos-generate-config --root /mnt
```

This will create a hardware-configuration.nix file in /mnt/etc/nixos that will capture the disk layout with nix. Add the "filesystems" option settings to your hosts/${hostname}/default.nix

ensure that the root partiiton is mounted on /mnt and the boot partition is mounted on /mnt/boot

Run:

```
nixos-install --flake (path-to-your-flake)#(your-hostname)
```

To Install the OS.