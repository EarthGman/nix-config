------------------------------------------------------------------------
You will first need an existing flake or NixOS installation. The easiest method to obtain one 
is to navigate to https://nixos.org/ and download the gnome graphical ISO.

Create a flake.nix and add the following input
```
    gman = { 
      url = "github:earthgman/nix-config";
      # reduce nixpkgs bloat and update modules independently of me
      inputs.nixpkgs.follows = "nixpkgs";
    };
```

Nixpkgs has no easy method of automatically extended the "lib" special arg, so you will have to append to it yourself

```
  outputs = { nixpkgs, gman, ... }:
  let
    # nixpkgs lib + home-manager lib + custom lib functions
    lib = gman.lib
  in
  {
    nixosConfigurations.nixos = lib.nixosSystem {
      # inject custom lib functions for access throughout modules
      specialArgs = { inherit lib; };
      modules = [ ... ];
	}
  }
```

Finally apply the overlay to nixpkgs.overlays

```
  nixosConfigurations.nixos = lib.nixosSystem {
      # inject custom lib functions for access throughout modules
      specialArgs = { inherit lib; };
      modules = [ 
      {
        nixpkgs.overlays = builtins.attrValues gman.overlays;
      }
      ...
      ];
	}
```

------------------------------------------------------------------------

# mkHost

Alternatively you can use an opinionated function wrapper I wrote for lib.nixosSystem to perform all the previous steps at once. (only hostname is required).

```
  nixosConfigurations.nixos = lib.mkHost {
    hostname = "nixos";
    bios = "UEFI"; # x86 only, one of "legacy" or "UEFI"
    cpu = "intel"; # x86 only, one of "intel" or "amd"
    gpu = "amd"; # x86 only, one of "intel" "nvidia" or "amd"
    system = "x86_64-linux"; # you know
    vm = false; # is this a qemu vm?
    server = false; # is this a server?
    stateVersion = "25.11" # version of nixos originally installed
    users = [ "bob" "alice" ]; # users that recieve a home-manager config
    configDir = ./hosts/nixos; # directory with extra modules
    extraSpecialArgs = { inherit inputs; }; # additional specialArgs
    extraModules = [ ./custom-module.nix ]; # additional module paths 
  };
```

------------------------------------------------------------------------

# Nixos Modules

you can enable my custom configurations using

```
# configuration.nix
gman.enable = true;
```

```
# List of all available modules
gman = {
  enable = false;
  android = { ... };
  bluetooth = { ... };
  desktop = { ... };
  determinate = { ... };
  direnv = { ... };
  enable = true;
  gnome = { ... };
  gpu = { ... };
  grub = { ... };
  hyprland = { ... };
  iphone = { ... };
  nh = { ... };
  onepassword = { ... };
  pipewire = { ... };
  printing = { ... };
  profiles = { ... };
  qemu-kvm = { ... };
  server = { ... };
  sops = { ... };
  ssh-keys = { ... };
  steam = { ... };
  stylix = { ... };
  suites = { ... };
  sway = { ... };
  tmux = { ... };
  zsh = { ... };
};
```

Each module under "gman" will act as a mixin that can each be enabled seperately. Some will be auto enabled by: gman.enable, but can be disabled again.

Some core nixos modules have been added for "programs" and "services" and you can view these using the nix repl.

most importantly config.meta now contains more metadata about your system. This information is filled in by the arguments provided to lib.mkHost for easy access throughout your modules, and will enable relevant modules automatically (assuming gman.enable = true). Although, this is not required.

------------------------------------------------------------------------
# Home Manager

For home-manager configurations integrated into NixOS, a

```
home-manager.enable
```

option has been added to your configuration options. I will admit that all this option does is tell the home-manager wrapper function to create a home configuration for all users under config.meta.users, and cannot completely disable home-manager if user configs are manually defined.