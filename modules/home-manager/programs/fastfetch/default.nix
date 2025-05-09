{ pkgs, lib, config, ... }:
let
  inherit (lib) mkEnableOption mkOption mkIf types getExe;
  cfg = config.programs.fastfetch;
  image-randomizer = pkgs.writeScript "fastfetch-image-randomizer.sh" ''
    #!${getExe pkgs.bash}

    images=(${toString (lib.concatStringsSep " " cfg.imageRandomizer.images)})
    image_count=''${#images[@]}
    random_index=$((RANDOM % image_count))
    selected_image=''${images[$random_index]}

    ${getExe cfg.package} -l "$selected_image"
  '';
in
{
  options.programs.fastfetch = {
    imperativeConfig = mkEnableOption "imperative config for fastfetch";
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
      settings = mkIf (!cfg.imperativeConfig) (import ./settings.nix { inherit config lib; });
    };
    # direct the alias to the randomizer script
    programs.zsh.shellAliases = {
      ff = "fastfetch";
    } //
    (if (cfg.imageRandomizer.enable)
    then
      {
        fastfetch = "${image-randomizer}";
      }
    else
      { fastfetch = "${getExe cfg.package}"; });
  };
}


