------------------------------------------------------------------------

The easiest way to install my configuration, especially for beginners, is from an existing NixOS install.

Navigate to https://nixos.org/ and download the gnome graphical ISO.

Boot the media and follow the onscreen installation instructions. Most options set do not matter as they will be overwritten anyway. However, it is important that you check "allow unfree software" when prompted.

From your freshly installed NixOS run 'sudo su' to gain root privileges. Navigate to the /etc/nixos directory and create a new file there called "flake.nix". For this I'll be using vim but nano is also acceptable. NixOS doesn't come preinstalled with Vim, but you can temporarily install it with

```bash
nix-shell -p vim
```

In flake.nix paste the following code:

```nix
{
    description = "my nix configurations";
    
	inputs = {
	  nix-config = {
	    url = "github:earthgman/nix-config";
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

This function serves as an abstraction layer for lib.nixosSystem which is the function responsible for reading nix configurations and building your system. This function should be used when building a host with my configuration because of several flags that are set via the specialArgs key of lib.nixosSystem and will automatically append my lib functions with those from nixpkgs.

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

Here we have created a default configuration template for a gnome-desktop, qemu/kvm x86_64 virtual machine running NixOS 25.11 and UEFI firmware with 1 user "bob".

Next you will need to:
- rm the configuration.nix file
- mkdir -p hosts/nixos (or the hostname of your choosing, must match exactly)
- mv hardware-configuration.nix hosts/nixos/default.nix
- If you specified anything under the users key: mkdir -p hosts/nixos/users/bob (or your user's name) and then create a default.nix in this directory.
- Now use your editor to create the user: vim hosts/nixos/users/bob/default.nix

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

**If for some reason the hardware-configuration.nix file does not exist, you can run "nixos-generate-config" to regenerate it.

The important parts of this file are "boot.initrd.availableKernelModules" and "filesystems"
because they are options specific to this host's hardware. The other options aren't important and can be removed or just left alone as they will be overwritten by the nix-config modules anyway.

And that is all you need for the basic setup. Now run

```bash
nixos-rebuild switch --flake /etc/nixos
```

------------------------------------------------------------------------
# Additional Configuration

**Using your own nixpkgs input:**

Typically people who use flakes will have their own pinned version of nixpkgs as an input and simply force other inputs to follow it. This is so it is possible to update or modify the package source without having to rely on the original flake maintainer (in this case, me) to update it.

```nix
    inputs = {
      # nixos-unstable
      nixpkgs = "https://flakehub.com/f/NixOS/nixpkgs/0.1.0.tar.gz";
      
	  nix-config = {
	    url = "github:earthgman/nix-config";
	    inputs.nixpkgs.follows = "nixpkgs";
	  };
	};
```

**Adding additional inputs:

You may want to add additional inputs beyond what exists in my flake. As of now these are accessed via an "inputs" argument passed to all modules which can be called from /hosts/${hostname}/default.nix:

```nix
{ inputs, ... }:
```

In order to append your own inputs to this key I have added an inputs key to mkHost and can be achieved like so:

```
    outputs = { self, nix-config, ... }:
	  let
	    inherit (nix-config) lib;
	    inputs = self.inputs // nix-config.inputs;
	  in
	  {
	    nixosConfigurations = { 
	      nixos = lib.mkHost {
	        inherit inputs # concatenate your inputs with mine
			hostName = "nixos";
			bios = "UEFI"; # double check which firmware your VM uses
			users = [ "bob" ];
			desktop = "gnome";
			vm = true;
			system = "x86_64-linux";
			stateVersion = "25.11";
			configDir = ./hosts/nixos;
	      };
	    };
	  };
```

If you want to references your own flake "outputs" within your nix modules simply repeat this process replacing the word inputs with outputs. 