EarthGman's nix flake ❄️ version 3


TODO:
- [ ] startup scripts - nordvpn start on login
- [ ] xremap
- [ ] i3
- [ ] redo and add more secrets
- [ ] fix the weird looking glass shm permission thing
- [ ] hard disk encryption
- [ ] disko for all other machines
- [ ] binary cache server
- [ ] remote building - trusted keys
- [x] update readme
- [-] replace neofetch with fastfetch
- [-] finish hyprland
- [ ] declarative wine and bottles programs?

Notes:
 - Uses the stable branch nixos-24.05 for most system packages. Unstable and Master exist as overlays
 - Built for x86_64 devices, in theory it should work for aarch64 but it is completely untested.
 - mutable users is set to false by default, dont get locked out like I did :(
 - Use x11. I do not support wayland at the moment.
 - while it is possible to enable multiple desktops at once it is strongly discouraged. Especially for complex desktops such as gnome, cinnamon, and plasma. 
 - cinnamon and plasma dont receive much support but they should function.
 - main display manager is sddm which cannot be themed if plasma6 is enabled due to differing qt versions. (plasma will launch with a black screen)
 - if you are using KDE Plasma you will have to imperatively open system settings > session > background Serives and disable Gnome GTK settings synchronization.
   otherwise plasma will write the file and home manager will complain that it is in the way. https://github.com/danth/stylix/issues/267
 - stylix does not work with cinnamon

Installation Steps: (mostly personal notes)
Pre install
1. clone repo
2. nix run nixpkgs#nixos-generators -- --format iso --flake .#iso-x86_64 -o result
3. For new systems or users add a nixosConfigurations and homeConfigurations key in the flake (see lib/helpers.nix for arguments). Then add any custom config under hosts/Hostname (disko, availiable kerenlModules, etc)

Install
1. Clone repo
2. disko --mode zap_create_mount ./hosts/hostname/disko.nix
3. if redeploying an existing system with secrets add age keys.txt to /mnt/var/lib/sops-nix
4. nixos-install --flake .#hostname

Post Install
1. login to github, discord, 1password, steam, etc
2. enable firefox extensions (idk how to enable these by default)
3. setup wine and bottles programs
4. redeploy qemu/kvm VMs