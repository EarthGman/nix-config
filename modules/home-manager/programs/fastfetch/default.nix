{ pkgs, lib, config, ... }:
let
  inherit (lib) mkEnableOption mkOption mkIf types getExe;
  cfg = config.programs.fastfetch;
  image-randomizer = pkgs.writeScript "fastfetch-image-randomizer.sh" ''
    #!/usr/bin/env bash

    images=(${toString (lib.concatStringsSep " " cfg.imageRandomizer.images)})
    image_count=''${#images[@]}
    random_index=$((RANDOM % image_count))
    selected_image=''${images[$random_index]}

    fastfetch -l "$selected_image"
  '';
in
{
  options.programs.fastfetch = {
    image = mkOption {
      description = "image used for fastfetch";
      type = types.str;
      default = "nixos";
    };
    imageRandomizer.enable = mkEnableOption ''
      whether to enable randomized fastfetch image display
      if unused, programs.fastfetch.image will be used instead
    '';
    imageRandomizer.images = mkOption {
      description = "list of images that will be passed to the fastfetch randomizer";
      type = types.listOf types.str;
      default = [ cfg.image ]; # just in case its enabled but no images are provided
    };
  };

  config = mkIf cfg.enable {
    programs.fastfetch = {
      settings = import ./settings.nix { inherit config lib; };
    };
    # direct the alias to the randomizer script
    programs.zsh.shellAliases =
      if (cfg.imageRandomizer.enable)
      then
        { ff = "${image-randomizer}"; }
      else
        { ff = "${getExe pkgs.fastfetch}  "; };
  };
}


