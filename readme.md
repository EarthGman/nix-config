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

Imperative actions upon installation:
  - connect to wifi or use ethernet cable
  - disko: configure disko.nix & run disko --mode zap_create_mount ./disko.nix
  - run nixos-generate-config --root /mnt && cd /mnt/etc/nixos
  - pull nix config: git pull https://github.com/EarthGman/nix-config
  - place hardware.nix into the respective hosts folder or make a new one if it doesn't exist
  - for new hosts:
    - configure boot and networking options respectively and place them into the host folder
    - add an entry for the host in flake.nix
  - age keys: /var/lib/sops-nix/keys.txt and .config/sops/age/keys.txt
After installation:
  - enable firefox extensions
  - login to 1password
  - login to discord
  - login to steam
  - symlink game saves to games drive (if applicable)
  gnome: 
    - enable extensions (dash, vitals, etc)
