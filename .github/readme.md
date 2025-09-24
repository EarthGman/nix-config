**EarthGman's Main Nix Flake ❄️ V7**

This flake contains my opinionated configuration framework for NixOS and Home Manager.

Supports:
- NixOS
- NixOS with Home Manager
- standalone Home Manager for many other Linux distributions
- Servers
- qemu/kvm virtual machines
- Gnome
- Hyprland
- Sway

------------------------------------------------------------------------
# Showcase

Gnome with Risk of Rain 2 theme:

![gnome](https://raw.githubusercontent.com/EarthGman/nix-config/refs/heads/main/.github/ror-gnome.png)

Sway with Undertale theme:

![sway](https://raw.githubusercontent.com/EarthGman/nix-config/refs/heads/main/.github/undertale-sway.png)

------------------------------------------------------------------------
# Getting Started

If you want to try my configurations for yourself, Here are two methods of doing so:

NixOS - https://github.com/EarthGman/nix-config/blob/main/docs/NixOS.md

Home-manager standalone - https://github.com/EarthGman/nix-config/blob/main/docs/Home%20Manager.md

------------------------------------------------------------------------
# Known Issues - Last updated: 8-14-2025

- NixOS is kind of bloated, especially if you use a lot of flakes. Flakes often place many copies of source repositories such as nixpkgs or install many copies of a program into the nix store. Each copy of nixpkgs placed into your nix store takes up ~420MB and this will only get worse as the repository grows in size. But then again, you paid for the whole disk right?

- On sway (possibly other wayland sessions that use the wlroots xdg-desktop-portal) If you have multiple monitors and want to screenshare via vesktop. It will ask you to pick a monitor.
  Pressing escape at this point to cancel the process crashes discord.

- using nixos rebuild will complain about channels being removed and that some directories should be removed. This affects nothing but you can manually rm these directories to remove the warning.
 
- gparted doesn't seem to work on wayland when launched normally. Use sudo -E gparted to launch the program from a terminal.

- Terminal transparency is lost when fullscreen is activated on sway. This is a feature of the wm and cannot be fixed.

- when using swww for wallpaper management, the current wallpaper will be lost if a monitor is powered off or disconnected.

- When launching using UWSM, XDG_CURRENT_DESKTOP is set to "sway:wlroots" while initalizing services in Sway. It is then later changed to "sway". 
  the wallpaper tester for waybar is affected by this behavior.
  This bug is completely unnoticable to users but could cause this feature to break in the future.

- Your display manager (prelogin screen) will contain 2 Sway sessions if you pick sway as your desktop: Sway and Sway (UWSM). You should pick the UWSM option.
  This is caused by underlying logic in nixpkgs and cannot be cleanly fixed.

- xwayland apps within wayland sessions have a bug in which the mouse will not be able to interact with the window if your monitor position contains a negative coordinate.
  This bug only affects setups with more than 1 monitor.

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
- [ ] add more showcase pictures
- [ ] rewrite old desktop themes from v6
- [x] cache website
- [x] install.sh
- [ ] configuration TUI written in rust
