**EarthGman's Main Nix Flake ❄️ V8 - The homeless update**

This flake contains my nixos configurations and configuration framework developed over the course of several years.

It is highly maintained by myself and a few others, and can be used by inexperienced people without much hassle. (some Linux experience is recommended)

If you are interested in Nix or NixOS, then this repository can serve as a well-refined example and reference of what can be accomplished with the language and OS.

------------------------------------------------------------------------
# Showcase

Windows-like Gnome experience

![gnome](https://raw.githubusercontent.com/EarthGman/nix-config/refs/heads/main/.github/ror-gnome.png)

Dedicated themes for Wayland window managers:

![sway](https://raw.githubusercontent.com/EarthGman/nix-config/refs/heads/main/.github/undertale-sway.png)

------------------------------------------------------------------------
# Getting Started

NixOS is known for being a very confusing distribution with little documentation.

Additionally, the official installer refuses to expose users to nix flakes (which are the real superpower of nix) out of the box, opting to use nix channels which are basically deprecated at this point.

This framework aims to improve upon the default NixOS experience by providing a more structured configuration framework for modularity and expandability.

Since I mostly wrote this for myself, my configurations will be used by default but can be slowly tweaked by your own flake over time, or just be outright disabled.

To obtain the installer navigate to https://cache.earthgman.net and download the nixos-installer.iso and its sha256sum (only supports x86_64 at this time).

If you don't want to put an iso image from a random guy on the internet into your PC, you can build the installer iso yourself. [Instructions](https://github.com/EarthGman/nix-config/blob/main/docs/build-iso.md)

if installing on bare metal, Use a program such as rufus, balena-etcher, or dd to flash the iso image to a usb stick.

the getty helpline will direct you through the installation process. [This document](https://github.com/EarthGman/nix-config/blob/main/docs/install.md) will provide a detailed summary of the install script for those who want to read about it before having to boot the installer.

------------------------------------------------------------------------
# Known Issues - Last updated: 10-12-2025

- On sway (possibly other Wayland sessions that use the wlroots xdg-desktop-portal) If you have multiple monitors and want to screenshare via vesktop. It will ask you to pick a monitor.
  Pressing escape at this point to cancel the process crashes discord.
 
- gparted doesn't seem to work on non-gnome Wayland window managers when launched normally. Use sudo -E gparted to launch the program from a terminal.

- Terminal transparency is lost when fullscreen is activated on sway. This is a feature of the wm and cannot be fixed.

- When launching using UWSM, XDG_CURRENT_DESKTOP is set to "sway:wlroots" while initalizing services in Sway. It is then later changed to "sway". 
  the wallpaper tester for waybar is affected by this behavior.
  This bug is completely unnoticable to users but could cause this feature to break in the future.

- Your display manager (prelogin screen) will contain 2 Sway sessions if you pick sway as your desktop: Sway and Sway (UWSM). You should pick the UWSM option.
  This is caused by underlying logic in nixpkgs and cannot be cleanly fixed.

- xwayland apps within wayland sessions have a bug in which the mouse will not be able to interact with the window if your monitor position contains a negative coordinate.
  This bug only affects setups with more than 1 monitor.

# Personal Notes
Imperative actions after install
- login to git
- login to discord
- login to steam
- import neomutt email accounts
- import gpg private keys
- ssh-add ssh private key
- reconfigure syncthing (maybe?)
- enable firefox extensions
- install protonup for steam
- /etc/nixos -> ~/src/github/earthgman/nix-config
- Install the English Dictionary extension for libreoffice (otherwise the spell checker wont work)
- setup any VMs
- reinstall wine/bottles programs

# TODO
- [ ] add more showcase pictures
- [ ] control panel configuration TUI for programs written in rust
- [ ] conduct user studies
  - [ ] nixos-installer
  - [ ] kde-plasma configuration
