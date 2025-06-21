------------------------------------------------------------------------

This guide is for installing a home-manager standalone configuration for another Linux distribution (tested with arch) or even Mac (untested).

**As mentioned in the readme, home-manager is not that good when used on its own. This is because unlike NixOS, your system configuration will differ from distribution to distribution. Certain programs or services that a particular home-manager module depends on may not be present.

If I somehow haven't scared you off yet and you still want to follow through with installing a standalone home-manager here is what I recommend using it for:
- installing apps that mostly manage themselves and are not managed by home-manager: gimp, libreoffice, davinci-resolve, etc
- Installing some additional packages such as fonts.
- config files for programs you rarely touch; in my case: tmux, kitty, zsh, ghostty, etc.
- creating out of store symlinks.

and just leave the more complex stuff to your distribution of choice.

To start, you will need to follow your distribution's guide to installing nix. I did this on arch (btw) through the determinate-nix installer found at https://zero-to-nix.com/start/install/

Now, create a flake with a homeConfigurations output.
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
	    homeConfigurations = { 
	      "bob@archlinux" = lib.mkHome {
		    username = "bob";
		    hostName = "archlinux";
		    desktop = "gnome";
		    stateVersion = "25.11";
		    profile = ./home/bob.nix; # or wherever you want it
		    system = "x86_64-linux";
	      };
	    };
	  };
```

Create the directory path and nix file specified in the "profile" key in the root of your flake.

Here you will specify options that will be consumed by home-manager, and each system can have a different home configuration entirely. Just specify a different.nix file.

**Default config will most likely not work out of the box depending on the distribution.
Certain system services and packages may need to be installed manually.