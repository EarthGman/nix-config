^=^=^=^ EarthGman's NixOS flake ❄️ v5 ^=^=^=^

Features
-  consumable modules
-  pre-configured zsh, neovim, yazi, tmux, desktops, and others.
-  sops support
-  active support for gnome, i3, sway, and hyprland
-  access to various images, fonts and more. https://github.com/EarthGman/assets
-  extended package and lib function set. https://github.com/EarthGman/nix-library

This NixOS configuration is designed to serve as an extension to nixpkgs, providing more lib functions, program, service, module, and profile options for pre-configured desktops, terminals, shells, neovim, and more. Easily consumable by others who are new to NixOS or just want a working system without having to learn nix or maintain a configuration repository themselves. 

------------------------------------------------------------------------
# Showcase

Gnome with Risk of Rain 2 theme:

![gnome](https://raw.githubusercontent.com/EarthGman/nix-config/refs/heads/main/.github/ror-gnome.png)

Sway with Undertale theme:

![sway](https://raw.githubusercontent.com/EarthGman/nix-config/refs/heads/main/.github/undertale-sway.png)

------------------------------------------------------------------------
# Getting Started
**Note**: This configuration is specifically designed with NixOS in mind. It has been tested on x86_64-linux and aarch64-linux, but as of now, nix-darwin has no support. It is possible to create standalone home-manager configurations using my home-manager modules on other Linux distributions or MacOS. I do not recommend this however, as home-manager on its own is not that great. The reasoning behind this statement will be explained later.

**Prerequisites**:
- Basic experience with Linux and knowledge of many Linux terms.

- experience with an editor such as: vscode, zed, neovim, emacs, etc as you will be working with many configuration files.

- A fresh NixOS installation. Download the graphical ISO from nixos.org and begin the installation process. Ensure that you allow unfree software.

- Time, patience, and the ability to learn a functional programming language with bad documentation. 
# Installation

From your freshly installed NixOS run 'sudo su' to gain root privileges. Navigate to the /etc/nixos directory and create a new file there called "flake.nix". For this I'll be using vim but nano is also acceptable. NixOS doesn't come preinstalled with Vim, but you can temporarily install it with

```bash
nix-shell -p vim
```

Inside of your flake.nix paste the following code:

```nix
{
    description = "my nix configurations";
    
	inputs = {
	  nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
	
	  nix-config = {
	    url = "github:earthgman/nix-config";
	    inputs.nixpkgs.follows = "nixpkgs";
	  };
	};
	
	outputs = { nix-config, ... }:
	  let
	    inherit (nix-config) lib;
	  in
	  {
	    nixosConfigurations = { 
	      nixos = lib.mkHost {
	      
	      };
	    };
	  };
}
```

You will then need to add various arguments to the mkHost function depending on the purpose or type of machine you are configuring. Here are the possible keys and values:

```nix
  {
    hostName # any string
    cpu # "amd" or "intel"
    gpu # "amd" "nvidia" or "intel"
    bios # "legacy" or "UEFI"
    users # array consisting of all "normal" users on the system
    desktop # "gnome" "i3" "sway" or "hyprland"
    server # true or false
    iso # true or false
    vm # true or false
    system # "x86_64-linux"
    stateVersion # "25.11"
    configDir # nix path to the configuration directory for this host
  }
```

This function serves as a high level wrapper for lib.nixosSystem which is the function responsible for reading nix configurations and building your system. The values passed into this function are used to toggle various modules based on the values specified.

Example:
```nix
nixos = lib.mkHost {
  hostName = "nixos";
  bios = "UEFI"; # double check which firmware your VM uses
  users = [ "bob" ];
  desktop = "gnome";
  vm = true;
  system = "x86_64-linux";
  stateVersion = "25.11";
  configDir = ./hosts/nixos;
};
```

Here we have created a default configuration template for a qemu/kvm x86_64 virtual machine running NixOS 25.11 and UEFI firmware with 1 user "bob".

Next you will need to:
- rm the configuration.nix file
- mkdir -p hosts/nixos (or the hostname of your choosing, must match exactly)
- mv hardware-configuration.nix hosts/nixos/default.nix
- If you specificed anything under the users key: mkdir -p hosts/nixos/users/bob (or your user's name) and then create a default.nix in this directory.
- Now use your editor to create the user:

```nix
{ pkgs, ...}:
{
  users.users.bob = {
    isNormalUser = true; # must be set for non system users
    extraGroups = [ "wheel" ]; # allow sudo for this user
    shell = pkgs.zsh; # better than bash
    password = "super-secure-password"; 
  };
}
```

If for some reason the hardware-configuration.nix file does not exist, you can run nixos-generate-config to regenerate it.

 The important parts of this file are "boot.initrd.availableKernelModules" and "filesystems"
because they are options specific to this host's hardware. The other options aren't important and can be removed or just left alone as they will be overwritten by the nix-config modules anyway.

And that is all you need for the basic setup. Now run

```bash
nixos-rebuild switch --flake /etc/nixos
```

# End of basic setup - write the rest of this later

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
- /etc/nixos -> ~/src/nix-config
- Pictures/wallpapers -> ~/src/assets/wallpapers
- Install the English Dictionary extension for libreoffice (otherwise the spell checker wont work)
- setup any VMs
- reinstall wine/bottles programs

# TODO
- [ ] add some more showcase pictures
- [ ] Nix build server
- [ ] installation helper scripts
