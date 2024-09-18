EarthGman's nix flake ❄️ version 4
Now with (hopefully) finalized framework

Changes from v3:
- revamped framework
- integrated home-manager into nixos
- removed support for plasma and cinnamon
- debloat
- externel repo for assets (wallpapers, binaries, etc)

Some Notes:
It is possible to enable multiple desktops at once but this is not recommended.
"gnome"
"i3"
"hyprland"
These can all be enabled by setting desktop = "gnome,i3,hyprland" in flake.nix
The first desktop in this string will be set as the default session within the display manager.

Multiple users can be enabled on each system, each has its own nixos and home-manager configuration located under 
hostname/users.
ex. users = "alice,bob" in flake.nix

The first user in this list is by default considered the power user.
Some modules will give this user extra permissions or add it to certain groups automatically.
Ex. modules/nixos/docker.nix 

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
- [x] hyprland
- [ ] remote building
- [ ] install scripts
- [ ] drive encryption
- [ ] vim
- [ ] zfs