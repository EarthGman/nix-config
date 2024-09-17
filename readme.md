EarthGman's nix flake ❄️ version 4
Now with (hopefully) finalized framework

Changes from v3:
- revamped framework
- integrated home-manager into nixos
- removed support for plasma and cinnamon
- debloat
- externel repo for assets (wallpapers, binaries, etc)

Supported desktops:
- gnome on xorg
- gnome on wayland
- i3
- hyprland

Supported display managers:
- sddm:
  - themes:
    - sddm-astronaut

supported bootloaders:
- grub:
  - themes:
    - nixos

Installation guide (mostly personal notes)
Pre-install:
- flake entry
- hosts folder with extra config and disko

Install:
- clone repo
- run disko
- mkdir /mnt/etc
- mv nix-config /mnt/etc/nixos
- nixos-install --flake .#yourhostname /etc/nixos

Post Install:
- firefox extension configuration
- 1password setup (login and 1password agent)
- login to apps (discord steam etc)
- run protonup for steam to download proton-ge

#TODO: in order of priority
- [ ] ssh keys
- [ ] hyprland
- [ ] remote building
- [ ] install scripts
- [ ] drive encryption
- [ ] vim
- [ ] zfs