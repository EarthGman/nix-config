{ inputs, ... }:
{
  imports = [
    ./disko.nix
    inputs.jovian-nixos.nixosModules.jovian
  ];

  modules = {
    benchmarking.enable = true;
    steam.enable = true;

    printing.enable = false;
  };

  programs = {
    prismlauncher.enable = true;
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
}
