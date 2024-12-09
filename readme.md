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

------------------------------------------------------------------------

# Why would I use this?

nix is hard, let somebody else deal with it.

This configuration provides fully configured shells, terminals, editors, desktops, and more so that you can start learning NixOS without going through the pain of creating a functional setup.
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
      # for default values see mkHost in lib/default.nix
      # for more examples see hosts/default.nix
      nixos = lib.mkHost {
        inherit inputs;
        hostName = "nixos";
        cpu = "intel";
        gpu = "nvdia";
        users = [ "bob" ];
        desktop = "hyprland";
        vm = false;
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

For some this is all that is needed depending on your use case.

------------------------------------------------------------------------
# NixOS with Home-manager

by default, if the users list is not empty home-manager will install and enable itself using

```
modules.home-manager.enable = true;
```

If you have many machines that all use the same username, you want to define a profile specific to your needs. You will need to feed your flake.nix a path where these profiles will live.

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

Personally I like to import another file such as hosts
/hostname/users/username/extrahm.nix

This allows you to specify certain configuration specific to that user on that host only, such as monitor setup.

# Standalone Home-manager
Coming Soon (lol)



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
- setup any VMs
- reinstall wine/bottles programs

# TODO
- [ ] finish readme and upload desktop showcase images
- [ ] redo rofi, fix rofi bug on hyprland
- [ ] neovim
- [ ] media server
- [ ] Nix build server
- [ ] installation helper scripts

