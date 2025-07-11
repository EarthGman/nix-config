**EarthGman's NixOS Flake ❄️ V6**

Features
-  consumable modules
-  pre-configured zsh, neovim, yazi, tmux, desktops, and others.
-  sops support
-  active support for gnome, i3, sway, and hyprland
-  create and set custom profiles for each host or user in your configuration.
-  access to various images, fonts and more. https://github.com/EarthGman/assets
-  additional packages and nix functions. https://github.com/EarthGman/nix-library

This NixOS configuration is designed to serve as an extension to nixpkgs, providing more lib functions, program, service, module, and profile options for pre-configured desktops, terminals, shells, neovim, and more. Easy to consume and setup from your own nixos flake. 

Good for beginners to NixOS and serves as demo to show just how much can be done with the distribution.

------------------------------------------------------------------------
# Showcase

Gnome with Risk of Rain 2 theme:

![gnome](https://raw.githubusercontent.com/EarthGman/nix-config/refs/heads/main/.github/ror-gnome.png)

Sway with Undertale theme:

![sway](https://raw.githubusercontent.com/EarthGman/nix-config/refs/heads/main/.github/undertale-sway.png)

------------------------------------------------------------------------
# Getting Started
**Note**: This configuration is specifically designed with NixOS in mind. It has been tested on x86_64-linux and aarch64-linux, but as of now, nix-darwin has no support. It is possible to create standalone home-manager configurations using my home-manager modules on other Linux distributions or MacOS. I do not recommend this however, as home-manager on its own is not that great. The reasoning behind this statement will be explained within the home-manager standalone installation guide.

**Prerequisites**:
- Basic experience with Linux and system management.

- experience with an editor such as: vscode, zed, neovim, emacs, etc as you will be working with many configuration files.

- Time, patience, and the ability to learn a functional programming language with bad documentation. 

If you want to try my config for yourself, Here are two methods of doing so:

NixOS - https://github.com/EarthGman/nix-config/blob/main/docs/NixOS.md

Home-manager standalone - https://github.com/EarthGman/nix-config/blob/main/docs/Home%20Manager.md

# Extra information

creating and using your own installation media - https://github.com/EarthGman/nix-config/blob/main/docs/Install%20media.md

Creating and managing NixOS and home-manager modules and profiles - https://github.com/EarthGman/nix-config/blob/main/docs/Profile%20Management.md

------------------------------------------------------------------------
# Known Issues - Last updated: 5-21-2025

- NixOS is kind of bloated, especially if you use a lot of flakes. Flakes often place many copies of source repositories such as nixpkgs or install many copies of a program into the nix store. Each copy of nixpkgs placed into your nix store takes up ~420MB and this will only get worse as the repository grows in size. But then again, you paid for the whole disk right?

- On sway (possibly other wayland sessions that use the wlroots xdg-desktop-portal) If you have multiple monitors and want to screenshare via vesktop. It will ask you to pick a monitor.
  Pressing escape at this point to cancel the process crashes discord.

- using nixos rebuild will complain about channels being removed and that some directories should be removed. This affects nothing but you can manually rm these directories to remove the warning.
 
- Missing firmware drivers for bluetooth or wireless. Sometimes you will have to add additional firmware packages. see /hosts/tater/default.nix

- gparted doesn't seem to work on wayland when launched normally. Use sudo -E gparted to launch the program from a terminal.

- Qemu / kvm is unfinished and quite buggy, Graphical issues are present due to the lack of proper graphics configuration with qemu.

- Terminal transparency is lost when fullscreen is activated on sway. This is a feature of the wm and cannot be fixed.

- when using swww for wallpaper management, the current wallpaper will be lost if a monitor is powered off or disconnected.

- When launching using UWSM, XDG_CURRENT_DESKTOP is set to "sway:wlroots" while initalizing services in Sway. It is then later changed to "sway". 
  Two home manager services, hyprland window creation, and the wallpaper tester for waybar are affected by this behavior.
  This bug is completely unnoticable to users but could cause these 2 services to break in the future.

- Your display manager (prelogin screen) will contain 2 Sway sessions if you pick sway as your desktop: Sway and Sway (UWSM). You should pick the UWSM option.
  This is caused by underlying logic in nixpkgs and cannot be cleanly fixed.

- xwayland apps within wayland sessions have a bug in which the mouse will not be able to interact with the window if your monitor position contains a negative coordinate.
  This bug only affects setups with more than 1 monitor.

- Steam on i3 has a weird issue where you will sometimes not be able to interact with the window until resizing or moving it.

- Nixpkgs fmt in Neovim contains an issue with formatting of multi line strings in which the entire string is indented due to tab characters confusing the formatter.

# Personal Notes

Imperative actions after install
- login to 1password
- setup 1password agent
- login to git
- login to discord
- login to thunderbird
- enable firefox extensions
- install protonup for steam
- /etc/nixos -> ~/src/github/earthgman/nix-config
- Pictures/wallpapers -> ~/src/github/earthgman/assets/wallpapers
- Install the English Dictionary extension for libreoffice (otherwise the spell checker wont work)
- setup any VMs
- reinstall wine/bottles programs

# TODO
- [ ] add some more showcase pictures
- [ ] Nix build server
- [ ] installation helper scripts
- [ ] Docs for sops secrets managment
- [ ] Move all icons wallpapers to a website rather than the assets repository
- [ ] Docs for sops secrets managment
