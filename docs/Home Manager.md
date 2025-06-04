------------------------------------------------------------------------

This guide is for installing a home-manager standalone configuration for another Linux distribution or even Mac.

**As mentioned in the readme, home-manager is not that good when used on its own. This is because unlike NixOS, your system configuration will differ from distribution to distribution. Certain programs or services that a particular home-manager module depends on may not be present.

If I somehow haven't scared you off yet and you still want to follow through with installing a standalone home-manager here is what I recommend using it for:
- installing apps that mostly manage themselves and are not managed by home-manager: gimp, libreoffice, davinci-resolve, steam, etc
- Installing some additional packages such as fonts.
- creating out of /nix/store symlinks.

and just leave the more complex stuff to your distribution of choice.

To start, you will need to follow your distribution's guide to installing nix. I did this on arch (btw) through the determinate-nix installer found at https://zero-to-nix.com/start/install/

For this you will need to create a flake with a homeConfigurations output.
Paste the following into a flake.nix:

```
    description = "my home-manager configurations";
    
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
	      "bob@nixos" = lib.mkHome {
		    username = "bob";
		    hostName = "archlinux";
		    desktop = "gnome";
		    stateVersion = "25.11";
		    profile = ./home/bob.nix;
		    system = "x86_64-linux";
	      };
	    };
	  };
```



