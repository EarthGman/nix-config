{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) getExe concatStringsSep;
  cfg = config.programs.fastfetch;
in
pkgs.writeShellScriptBin "ff-image-randomizer" ''
  images=(${toString (concatStringsSep " " cfg.imageRandomizer.images)})
  image_count=''${#images[@]}
  random_index=$((RANDOM % image_count))
  selected_image=''${images[$random_index]}

  ${getExe pkgs.fastfetch} -l "$selected_image"
''
