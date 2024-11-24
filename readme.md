EarthGman's nix flake ❄️ version 4
Theoretical infinitely expandable configuration framework

Changes from v3:
- revamped framework
- integrated home-manager into nixos
- removed support for plasma and cinnamon
- debloat
- externel repo for assets (wallpapers, binaries, etc)

Some Notes:
- While this should theoretically work for nixos systems with aarch64-linux It is completely untested. for now only x86_64-linux is supported.
- It is possible to enable multiple desktops at once, However I do not recommend this with gnome and any other desktop as it is very large, sets many conflicting options behind the scenes, and causes a lot of weirdness when paired with other desktops. As of now i3 and hyprland can be enabled together as a dual-boot/log setup with wayland and x11.

Multiple users can be enabled on each system, each has its own nixos and home-manager configuration located under 
hostname/users.
enable an arbitrary amount of users assuming that configuration for each is present:

```nix
# flake.nix
users = "alice,bob";
```

Installation guide (mostly personal notes)
Pre-install:
- flake entry with intended hostname as the key
- hosts folder with extra config and disko

Install:
- clone repo
- run disko
- mkdir /mnt/etc
- mv nix-config /mnt/etc/nixos
- If sops secrets is used do not forget to move private key into /mnt/var/lib/sops-nix/keys.txt
- nixos-install --flake .#yourhostname /mnt/etc/nixos

Post Install:
- firefox extension configuration
- 1password setup (login and 1password agent)
- login to apps (discord steam etc)
- run protonup for steam to download proton-ge

#TODO: in order of priority
- [x] ssh keys
- [x] hyprland
- [ ] vim
  - [x] telescope
  - [ ] learn and configure all basic keybinds
  - [-] core options
  - [x] essential plugins
    - [-] treesitter - dont include all languages
    - [x] harpoon
    - [x] undo tree
    - [x] vim-fugitive
  - [x] language server configuration
  - [ ] debugger
  - [-] themes and styling - gruvbox works for now might change later
  - [ ] reimplement in nixvim using only nix
- [ ] remote building
  - [ ] rewrite remote building script
- [x] docker/portainer
- [ ] i3, hyprland synchronization
- [ ] zfs
- [ ] drive encryption
- [ ] autoinstall scripts
