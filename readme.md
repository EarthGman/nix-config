^=^=^=^ EarthGman's NixOS flake ❄️ v5 ^=^=^=^

Changes from v4:
- exposed various modules and profiles as flake outputs
- update to NixOS 25.05
- no longer a mono-repo, NixOS modules/profiles are consumable by other NixOS configuration repositories
- remove some overhead, unused functions, programs, etc

Features
-  extremely modular
-  support for multiple users on a single machine
-  sops support
-  active support for gnome, i3, and hyprland
-  access to various images, fonts and more. https://github.com/EarthGman/assets

Note: for shells, only zsh is supported.

------------------------------------------------------------------------

# Why would I use this?

nix is hard, let somebody else deal with it.

This configuration provides fully configured terminals, editors, desktops, and more so that you can start learning nix and NixOS without simultaneously fighting an unconfigured desktop.
Most settings will be personalized to myself by default, but they can be easily overwritten using your own NixOS repository.

# Getting Started

Start by creating a blank repository with a flake.nix.
your basic flake.nix should have the following structure.

```nix
{
  description = "my nixos configurations";

  inputs = {
    nix-config.url = "github:EarthGman/nix-config";
  };

  outputs = { self, nix-config, ... } @ inputs:
    let
    
      # merge nixpkgs.lib with my custom lib functions
      inherit (nix-config) lib
      
      # merge my inputs and your inputs
      inputs = nix-config.inputs // self.inputs;
    in
  {
    nixosConfigurations = {
      # for explaination and default values see mkHost in lib/default.nix
      # for more examples see hosts/default.nix
      nixos = lib.mkHost {
        inherit inputs;
        hostName = "nixos";
        cpu = "intel";
        gpu = "nvdia";
        users = [ "bob" ];
        desktop = "hyprland";
        vm = false;
        iso = false;
        server = false;
        platform = "x86_64-linux";
        stateVersion = "25.05";
        configDir = ./hosts/nixos;
      };
    };
  };
}
```

This will create a single host with a few special arguments that will enable various modules depending on the values provided. You can provide extra configuration specific to your host via the configDir argument.

Create the directory provided to configDir, in this case hosts/nixos. In this directory you want to create a default.nix and specify hardware configuration specific to your host. To get these modules run: 

```bash
# for general use
nixos-generate-config

# if you are currently installing
nixos-generate-config --root /mnt

# or if you are using disko partitioning
nixos-generate-config --no-filesystems --root /mnt
```

only the filesystems and kernel modules from hardware-configuration.nix are required.

Next,  you will need to customize your host to your preferences. Modules and profiles can be found under /profiles and /modules respectively and nixos modules can be enabled using the modules option.

To view all available and enabled modules you can use the nix repl
```nix-repl
:lf *pathtonixconfig*
nixosConfigurations.nixos.config.modules
```

If you intend to have a human controlled user it will need configuration using users.users. Create a "users" folder under hosts/$yourhostname. In this folder create another folder with your username and a default.nix inside. The contents of default.nix should look similar to

```nix
users.users.bob = {
  isNormalUser = true;
  extraGroups = [ "wheel" ];
  shell = pkgs.zsh;
  password = "123";
};
```

You now have a basic NixOS configuration.

------------------------------------------------------------------------
# NixOS with Home-manager

by default, if the users list from the mkHost function is not empty, home-manager will enable itself and create a configuration for all users present inside.
Set

```
modules.home-manager.enable = false;
```

somewhere in your NixOS configuration if you do not wish to use home-manager with your NixOS configuration.

You must create a user profile for configuration that will be shared with home-manager among all of your machines. You can place this directory anywhere in your flake, but must your flake.nix the path where these profiles will live using the following option. 

Example:

```nix
# default.nix
home-manager.profilesDir = ../../home;
```

profiles will need to be files with your username followed by a .nix extension. A sample is provided below

```nix
# bob.nix
{ inputs, ... }:
{
  imports = [
    inputs.nix-config.homeProfiles.desktopThemes.inferno
  ];

  programs = {
    git = {
      userName = "Bob";
      userEmail = "bob@bob.com";
    };

    discord.enable = true;
    freetube.enable = true;
    prismlauncher.enable = true;
    pipes.enable = true;
    cava.enable = true;
    sl.enable = true;
  };
  
  wayland.windowManager.hyprland.settings.input.left_handed = true;
}
```

You can set and override any default Home-manager configuration and apply it to all machines using this file. Additionally you can create a secondary home-manager configuration file to hosts/hostname/users/username and import this file to specify configuration specific for said user on that one host (such as a multi monitor setup).

------------------------------------------------------------------------
# Home-manager Standalone

For a standalone home-manager installation on Mac or another Linux distribution, home-manager should be used primarily as a means to install your dotfiles and/or user controlled programs. It is likely that it will not work directly out of the box if something is not properly configured on your system (such as the lack of xdg-desktop-portals for example).

start by creating the following flake.nix

```flake.nix
{
  description = "my home configurations";

  inputs = {
    nix-config.url = "github:EarthGman/nix-config";
  };

  outputs = { self, nix-config, ... } @ inputs:
    let
    
      # merge nixpkgs.lib with my custom lib functions
      inherit (nix-config) lib
      
      # merge my inputs and your inputs
      inputs = nix-config.inputs // self.inputs;
    in
    {
      homeConfigurations = {
        "bob@my-hostname" = lib.mkHome {
          inherit inputs;
          username = "bob";
          hostName = "my-hostname";
          desktop = null # possible values: null "gnome" "sway" "i3" "hyprland"
          stateVersion = "25.05";
          platform = "x86_64-linux";
          profile = ./home/bob.nix;
        };
      };
    }; 
}
```

next you will need to create a bob.nix in the path specified in the profile argument to the mkHome function

example bob.nix

```nix
{ inputs, ... }:
{
  imports = [
    inputs.nix-config.homeProfiles.desktopThemes.inferno
  ];

  programs = {
    git = {
      userName = "Bob";
      userEmail = "bob@bob.com";
    };

    discord.enable = true;
    freetube.enable = true;
    prismlauncher.enable = true;
    pipes.enable = true;
    cava.enable = true;
    sl.enable = true;
  };
  
  wayland.windowManager.hyprland.settings.input.left_handed = true;
}
```

You can also create ./hosts/$yourhostname/bob.nix and import the file from your main bob.nix to import configuration specific to a certain host (such as multi monitor setup)
just be sure to actually import this file in the imports of bob.nix

example implementation:

```nix
#bob.nix
{ hostName, ... }:
imports = [
  ../hosts/${hostName}/bob.nix
];
```

------------------------------------------------------------------------

# Darwin 
Coming Soon

------------------------------------------------------------------------

# Known Issues

- MSI (possibly others) UEFI Firmware unable to find the grub efi file.
- Missing drivers not included in boot.enableRedistributableFirmware (such as broadcom_sta) see /hosts/tater/default.nix
- Qemu / kvm is unfinished and quite buggy, Graphical issues are present due to the lack of proper graphics configuration with qemu.
- lack of support for other shells in nixos and home-manager (zsh only)
- some windows in sway will lose transparency in fullscreen
- currently, wayland desktops use swww by default to set the desktop wallpapers, so the wallpaper on your monitor will be lost if powered off or disconnected.

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
- [x] FIX SYSTEMD FOR WAYLAND
  - [x] learn systemd unit triggers
- [x] rofi only shows up on 1 monitor on sway
- [ ] kanshi profile for school setup
- [ ] fix swww wallpaper loss on monitor poweroff
  - [ ] lost transparency when fullscreen in sway
- [ ] finish readme and other .github setup
- [x] redo rofi, fix rofi bug on hyprland
- [x] alternative systemd setup for "Hyprland (systemd-session)"
- [ ] neovim
  - [ ] Clipboard issues
  - [ ] standardize keybinds
  - [ ] nicer interface configuration
  - [ ] debugger for C and cpp
  - [ ] lsp and debugger for Go
  - [ ] lsp and debugger for Rust
- [x] Home-manager standalone for Mac and other Linux Distros
- [ ] Darwin Modules for Kriswill
- [ ] system security
 - [-] secure boot - discontinued this is completely useless
 - [x] drive encryption with LUKS
- [ ] media server
- [ ] Nix build server
- [ ] installation helper scripts

