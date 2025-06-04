------------------------------------------------------------------------

My NixOS configuration comes with...my configurations and profiles. While these are totally awesome and usable, many would like to branch out and experiment with creating their own configurations. Thats where my profile system comes into play.

One of the most important tools when working with nix and nix flakes is the nix repl. This tool allows you to evaluate nix and NixOS options in real-time.

# NixOS

When consuming my Nix modules, NixOS will recieve a "modules"  and "profiles" toplevel config options. These can then be accessed from the nix repl 

```
# load the flake
:lf .

nixosConfigurations.(your-host).config.modules
nixosConfigurations.(your-host).config.profiles
```

Many of the modules are wrapped configuration options typically from the NixOS wiki so that they work for most use cases out of the box. These are core modules that are not meant to be altered heavily.

Profiles on the other hand define a set of programs you may want to create your own configurations of: zsh, tmux, vim, etc.

Profiles and Modules can be enabled or disabled using your /hosts/(hostname)/default.nix or files that it imports: Here is a sample of options available

**Modules

```
nix-repl> :p nixosConfigurations.cypher.config.modules
{
  android = { enable = true; };
  benchmarking = { enable = true; };
  bluetooth = { enable = true; };
  bootloaders = {
    grub = { enable = true; };
    systemd-boot = { enable = false; };
  };
  desktop = { enable = true; };
  desktops = {
    gnome = { enable = false; };
    hyprland = { enable = false; };
    i3 = { enable = false; };
    sway = { enable = true; };
  };
  direnv = { enable = true; };
  display-managers = {
    sddm = { enable = true; };
  };
  docker = { enable = false; };
  flatpak = { enable = true; };
  gpu = {
    amd = { enable = true; };
    intel = { enable = false; };
    nvidia = { enable = false; };
  };
  home-manager = { enable = true; };
  ifuse = { enable = false; };
  iso = { enable = false; };
  ledger = { enable = true; };
  nh = { enable = true; };
  onepassword = { enable = true; };
  pipewire = { enable = true; };
  printing = { enable = true; };
  qemu-guest = { enable = false; };
  qemu-kvm = { enable = true; };
  sops = { enable = true; };
  ssh = { enable = true; };
  steam = { enable = true; };
  zsa-keyboard = { enable = true; };
}
```

**Profiles

```
nix-repl> :p nixosConfigurations.cypher.config.profiles
{
  cli-tools = { enable = true; };
  default = { enable = true; };
  essentials = { enable = false; };
  gaming = { enable = true; };
  gman-pc = { enable = true; };
  gmans-keymap = { enable = true; };
  hacker-mode = { enable = true; };
  hardware-tools = { enable = true; };
  laptop = { enable = false; };
  server = {
    default = { enable = false; };
    docker-env = { enable = false; };
    minecraft = { enable = false; };
    personal = { enable = false; };
  };
  tmux = {
    default = { enable = true; };
  };
  wg0 = { enable = true; };
  zsh = {
    default = { enable = true; };
  };
```

**Note write the rest of this later