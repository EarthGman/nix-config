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

# Home-manager

------------------------------------------------------------------------

Home-manager is where most of the customization happens. home-manager configurations are provided with a "profiles" and a "custom" top-level configuration option:

**profiles**

```
nix-repl> :p nixosConfigurations.cypher.config.home-manager.users.g.profiles
{
  alacritty = {
    default = { enable = true; };
    tranq = { enable = false; };
  };
  bat = {
    default = { enable = true; };
  };
  cli-tools = { enable = true; };
  default = { enable = true; };
  desktopThemes = {
    april = { enable = false; };
    ashes = { enable = false; };
    celeste = { enable = false; };
    cosmos = { enable = true; };
    faraway = { enable = false; };
    headspace = { enable = false; };
    hollow-knight = { enable = false; };
    inferno = { enable = false; };
    nightmare = { enable = false; };
    undertale = { enable = false; };
    vibrant-cool = { enable = false; };
  };
  desktops = {
    gnome = {
      default = { enable = false; };
    };
    hyprland = {
      default = { enable = true; };
    };
    i3 = {
      default = { enable = true; };
    };
    sway = {
      default = { enable = true; };
    };
  };
  dunst = {
    default = { enable = true; };
  };
  essentials = { enable = true; };
  fastfetch = {
    default = { enable = true; };
  };
  firefox = {
    betterfox = { enable = false; };
    default = { enable = false; };
    shyfox = { enable = true; };
  };
  kitty = {
    default = { enable = true; };
  };
  lazygit = {
    default = { enable = true; };
  };
  polybar = {
    default = { enable = true; };
  };
  rmpc = {
    default = { enable = true; };
  };
  rofi = {
    default = { enable = true; };
  };
  starship = {
    default = { enable = true; };
  };
  stylix = {
    default = { enable = true; };
  };
  swaylock = {
    default = { enable = true; };
  };
  tmux = {
    default = { enable = true; };
  };
  vscode = {
    default = { enable = true; };
  };
  waybar = {
    default = { enable = true; };
  };
  yazi = {
    default = { enable = true; };
  };
  zsh = {
    default = { enable = true; };
  };
}
```

**custom**

```
nix-repl> :p nixosConfigurations.cypher.config.home-manager.users.g.custom
{
  browser = "firefox";
  editor = "nvim";
  fileManager = "nautilus";
  profiles = {
    alacritty = "default";
    bat = "default";
    desktopTheme = "cosmos";
    desktops = {
      gnome = "";
      hyprland = "default";
      i3 = "default";
      sway = "default";
    };
    dunst = "default";
    fastfetch = "default";
    firefox = "shyfox";
    kitty = "default";
    lazygit = "default";
    polybar = "default";
    rmpc = "default";
    rofi = "default";
    starship = "default";
    stylix = "default";
    swaylock = "default";
    tmux = "default";
    vscode = "default";
    waybar = "default";
    yazi = "default";
    zsh = "default";
  };
  terminal = "kitty";
  wallpaper = "/nix/store/mz2937pg49fld07479avhl7biyj2dz4l-space-piano.png";
}
```

Here you can see several customization options related to your terminal type, browser, file manager, editor, and which profile is used for each program. These options are used to power other modules within your home-manager configuration. For example when custom.browser is set to "firefox" the hyprland keybind for the browser (win+b in my case) will execute firefox. If you set it to "brave" it will instead launch brave. Same story with terminal, fileManager, and editor.

All profiles are set to "default" by the default home-manager profile and can be set to "" to disable all profiles associated with that program.

If you want to create a custom profile, start by creating a /modules/home-manager/profiles directory in your configuration and place a .nix file of the program you want to configure. Ensure that the .nix file is being imported by home-manager.

Define the profile and custom configuration
Ex:

```
{ lib, config, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.profiles.kitty.custom-kitty;
in
{
    options.profiles.kitty.custom-kitty.enable = mkEnableOption "my kitty profile";
	config = mkIf cfg.enable {
	  programs.kitty = {
	    settings = {
		font_family = "MesloLGS Nerd Font";
		update_check_interval = 0;
		tab_bar_style = "powerline";
		tab_powerline_style = "slanted";
		confirm_os_window_close = 0;
		copy_on_select = "clipboard";
		enable_audio_bell = "no";
		hide_window_decorations = "no";
		placement_strategy = "center";
		scrollback_lines = 20000;
		background_opacity = lib.mkForce "0.87";
		initial_window_width = 640;
		initial_window_height = 400;
		sync_to_monitor = "yes";
	  };
	};
  };
}

```

Then set 

```
custom.profiles.kitty = "custom-kitty";
```

Somewhere in your home-manager configuration.