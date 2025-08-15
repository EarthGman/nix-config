
Home Manager can be enabled as a standalone configuration on many Linux distributions and even MacOS.

add the flake input

```
gman = {
  url = "github:earthgman/nix-config";
  inputs.nixpkgs.follows = "nixpkgs";
};
```

extend lib and apply overlays

```
outputs = { gman, ... }:
let
  lib = gman.lib;
in
homeConfigurations = lib.homeManagerConfiguration {
  modules = [
    {
      nixpkgs.overlays = builtins.attrValues gman.overlays;
    }
    ...
  ];
  extraSpecialArgs = {
    inherit lib;
  };
};
```

home-manager modules are accessible via

```
gman.enable = true;
```

or individually from this list:

```
{
  desktop = { ... };
  enable = true;
  gnome = { ... };
  hyprland = { ... };
  kitty = { ... };
  lh-mouse = { ... };
  profiles = { ... };
  rmpc = { ... };
  scripts = { ... };
  smallscreen = { ... };
  sops = { ... };
  ssh-keys = { ... };
  stylix = { ... };
  suites = { ... };
  sway = { ... };
  tmux = { ... };
  vscode = { ... };
  yazi = { ... };
  zsh = { ... };
}
```

both these and other "programs" and "services" can be explored using the nix repl. 

------------------------------------------------------------------------
# mkHome

You can use an opinionated wrapper for lib.homeManagerConfiguration, which will perform the required setup automatically and assign metadata to config.meta. (both username and hostname arguments are required)

```
homeConfigurations."bob@nixos" = {
  username = "bob";
  hostname = "nixos";
  system = "x86_64-linux"; # system type
  profile = ./home/bob; # path to extra user configuration based on username
  secretsFile = ./home/bob/secrets.yaml # file for secrets
  stateVersion = "25.11"; # version of home-manager
  extraModules = [ ./another-module.nix ];
  extraExtraSpecialArgs = { inherit inputs; }; # more special arguments
};
```