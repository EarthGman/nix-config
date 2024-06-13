EarthGman's nix flake ❄️ version 3


TODO:
- [x] installer iso
- [ ] startup scripts - nordvpn start on login
- [ ] xremap
- [ ] hyprland
- [x] discord audio wayland
- [x] stylix - mouse cursor bug on gnome
- [ ] secrets
- [ ] mangohud
- [ ] fix the weird looking glass shm permission thing
- [x] replace the booleans
- [ ] icon problem on GNOME
- [x] fix printing module
- [ ] hard disk encryption

Installation steps
  - connect to wifi or use ethernet cable
  - pull nix config: git pull https://github.com/EarthGman/nix-config to somewhere on the disk
  - for new hosts create a new folder under hosts with the machine's name then add a host and home entry to flake.nix
  - disko: located in the respective hosts folder. configure disko.nix & run disko --mode zap_create_mount ./disko.nix to partition the drive
  - run nixos-generate-config --root /mnt
  - place hardware.nix into the respective hosts folder: mv /mnt/etc/nixos/hardware-configuration.nix ./hosts/hostname/hardware.nix
  - configure boot and networking options respectively from configuration.nix and place them into the host folder
  - age keys: to be written

After installation:
  - enable firefox extensions
  - login to 1password
  - login to discord
  - login to steam
  - symlink game saves to games drive (if applicable)
  gnome: 
    - enable extensions (dash, vitals, etc)
