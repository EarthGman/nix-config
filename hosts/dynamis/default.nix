{ pkgs, inputs, ... }:
{
  imports = [
    ./disko.nix
    inputs.jovian-nixos.nixosModules.jovian
  ];

  time.timeZone = "America/Chicago";

  gman = {
    printing.enable = false;
    steam.enable = true;
  };

  jovian = {
    steam = {
      enable = true;
      # autoStart = true;
      user = "bean";
    };

    # IMPERATIVE ACTION REQUIRED: touch ~/.steam/steam/.cef-enable-remote-debugging
    decky-loader.enable = true;

    hardware.has.amd.gpu = true;
  };

  programs = {
    prismlauncher.enable = true;
    dolphin-emu.enable = true;
    cemu.enable = true;
    ryubing.enable = true;
    discord.enable = true;
    ffxiv-launcher.enable = true;
    lutris.enable = true;
    bottles.enable = true;
    gcolor.enable = true;
    filezilla.enable = true;
    cmatrix.enable = true;
    cbonsai.enable = true;
    pipes.enable = true;
    sl.enable = true;
  };

  environment.systemPackages = with pkgs.coolercontrol; [
    coolercontrol-gui
    coolercontrold
  ];
}
