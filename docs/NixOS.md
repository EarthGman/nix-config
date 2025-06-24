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

Here we have created a default configuration template for a gnome-desktop, qemu/kvm x86_64 virtual machine running NixOS 25.11 and UEFI firmware with 1 human controlled user "bob".

Next you will need to:
- rm the configuration.nix file
- mkdir -p hosts/nixos (or the hostname of your choosing, must match exactly)
- mv hardware-configuration.nix hosts/nixos/default.nix
- If you specified anything under the users argument: mkdir -p hosts/nixos/users/bob (or your user's name) and then create a default.nix in this directory.
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

**Adding additional arguments and inputs

lib.nixosSystem comes with a "specialArgs" argument which allows for conditional functionality within nix modules without resulting in an infinite recursion error. Arguments of mkHost will pass needed specialArgs to the shared NixOS modules. However, you will probably want to add additional arguments to make your own module configuration easier.

This is done through the extraSpecialArgs key of the function.

```
    outputs = { self, nix-config, ... } @ inputs:
	  let
	    inherit (nix-config) lib;
	    inherit (self) outputs;
	  in
	  {
	    nixosConfigurations = { 
	      nixos = lib.mkHost {
			hostName = "nixos";
			bios = "UEFI"; # double check which firmware your VM uses
			users = [ "bob" ];
			desktop = "gnome";
			vm = true;
			system = "x86_64-linux";
			stateVersion = "25.11";
			configDir = ./hosts/nixos;

            extraSpecialArgs = { inherit self inputs outputs; };
	      };
	    };
	  };
```

In this example you pass the "self" "inputs" and "outputs" of your own nix flake into your modules, allowing you to directly reference them.

Ex: (Don't blindly Copy paste)
```
# hosts/nixos/default.nix
{ self, inputs, outputs; };

imports = [
  (self + "/modules/my-module.nix")
  inputs.cool-repo-you-found.nixosModules.default
];

nixpkgs.overlays = outputs.overlays 
```

------------------------------------------------------------------------
# Home-manager

My nix config comes with home-manager configured with desktop use in mind. By default it is enabled if a desktop is installed and if a human controlled user exists on the system. However it can be disabled with:

```
modules.home-manager.enable = false;
```

in NixOS. Every user specified under the users argument of mkHost will have a configuration automatically generated for them.

Typically, you would want to have user configuration specific to you for various purposes such as git credentials, or sops secrets applied to all users of your name on all machines you own. 

 To do this you can define a (username).nix file. I put all of mine under a /home directory (relative to your nix flake project, not /home on your filesystem). Then, point home-manager to consume the file in that directory using:

``` 
home-manager.profilesDir = (path to the directory containing your username.nix file);
```

As an inspiration of what you should add to this file, here is an example of my main home manager profile:

```nix
{ self, config, pkgs, lib, hostName, ... }:
let
  inherit (lib) mkDefault;
  enabled = { enable = mkDefault true; };
  signingkey = keys.g_ssh_pub;
  LHmouse = builtins.toFile "lh-mouse.xmodmap" "pointer = 3 2 1";
  extraHM = self + /hosts/${hostName}/users/g/preferences.nix;
in
{
  imports = lib.optionals (builtins.pathExists extraHM) [
    extraHM
  ];

  profiles = {
    essentials.enable = mkDefault true;
  };

  custom = {
    profiles.firefox = "shyfox";
  };

  programs = {
    git = {
      userName = "EarthGman";
      userEmail = "EarthGman@protonmail.com";
      signing = {
        key = signingkey;
        signByDefault = true;
        signer = "";
      };
      extraConfig = {
        gpg.format = "ssh";
        gpg."ssh".program = "${pkgs._1password-gui}/bin/op-ssh-sign";
        init.defaultBranch = "main";
      };
    };
    zsh = {
      shellAliases = {
        edit-config = "cd ~/src/nix-config && $EDITOR .";
      };
      initContent = ''
        export MANPAGER='nvim +Man!'
      '';
    };
    neovim-custom = {
      viAlias = true;
      vimAlias = true;
    };
    rmpc = enabled;
    bottles = enabled;
    bustle = enabled;
    freetube = enabled;
    filezilla = enabled;
    gcolor = enabled;
    ghex = enabled;
    museeks = enabled;
    moonlight = enabled;
    okular.enable = true;
    obs-studio = enabled;
    prismlauncher = enabled;
    discord = enabled;

    mov-cli = {
      enable = true;
      plugins = [ pkgs.mov-cli-youtube ];
    };

    # fun and useless
    pipes = enabled;
    cbonsai = enabled;
    cmatrix = enabled;
    cava = enabled;
    sl = enabled;
  };

  programs.ssh = {
    enable = true;
    forwardAgent = true;
    extraConfig = "IdentityAgent ${config.home.homeDirectory}/.1password/agent.sock";
  };

  xsession.windowManager.i3.config.startup = [
    {
      command = "${lib.getExe pkgs.xorg.xmodmap} ${LHmouse}";
      always = true;
      notification = false;
    }
  ];
  wayland.windowManager = {
    sway.config.input = {
      "type:pointer" = {
        left_handed = "enabled";
      };
    };
    hyprland.settings = {
      animations.enabled = false;
      input.left_handed = true;
    };
  };
}
```

You can also specify extra home-manager configuration in your /hosts/(hostname)/users/(username) folder for configuration specific to that host (such as for a multi monitor setup)

Ex:
```
{ keys, pkgs, config, lib, ... }:
let
  username = "g";
in
{
  sops.secrets.${username}.neededForUsers = true;
  users.users.${username} = {
    initialPassword = "";
    hashedPasswordFile = lib.mkIf (config.sops.secrets ? ${username}) config.sops.secrets.${username}.path;
    password = null;
    isNormalUser = true;
    openssh.authorizedKeys.keys = [ keys.g_ssh_pub ];
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
      "qemu-libvirtd"
      "wireshark"
      "docker"
      "adbusers"
    ];
  };
  
  home-manager.users.g = {
    services.kanshi = {
	    enable = true;
	    settings = [
	      # https://gitlab.freedesktop.org/xorg/xserver/-/issues/899
	      {
	        profile.name = "home";
	        profile.outputs = [
	          {
	            criteria = "LG Electronics LG HDR 4K 0x0007B5B9";
	            position = "1920,0";
	            mode = "2560x1440@59.951Hz";
	          }
	          {
	            criteria = "Sceptre Tech Inc Sceptre F24 0x01010101";
	            position = "0,0";
	            mode = "1920x1080@100Hz";
	          }
	        ];
	      }
	      {
	        profile.name = "school";
	        profile.outputs = [
	          {
	            criteria = "Philips Consumer Electronics Company PHL BDM4350 0x000005E8";
	            position = "1920,0";
	            mode = "2560x1440@59.95Hz";
	          }
	          {
	            criteria = "Sceptre Tech Inc E24 0x01010101";
	            position = "0,0";
	            mode = "1920x1080@74.97Hz";
	          }
	        ];
	      }
	    ];
	  };
  };
}

```
