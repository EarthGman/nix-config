{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.programs.fastfetch;

  image-randomizer = pkgs.writeShellScript "fastfetch-image-randomizer.sh" ''
    images=(${toString (lib.concatStringsSep " " cfg.imageRandomizer.images)})
    image_count=''${#images[@]}
    random_index=$((RANDOM % image_count))
    selected_image=''${images[$random_index]}

    fastfetch -l "$selected_image"
  '';
in
{
  options.programs.fastfetch = {
    imperativeConfig = lib.mkEnableOption "imperative config for fastfetch";

    image = lib.mkOption {
      description = "image used for fastfetch";
      type = lib.types.str;
      default = "nixos";
    };

    imageRandomizer = {
      enable = lib.mkEnableOption "fastfetch image randomizer";

      images = lib.mkOption {
        description = "list of image nix-paths that will be passed to the fastfetch randomizer";
        type = lib.types.listOf lib.types.str;
        default = [ cfg.image ]; # just in case its enabled but no images are provided
      };
    };
  };

  config = lib.mkIf cfg.enable {
    # maybe uncessessary but eh
    programs.fastfetch = {
      settings =
        if (cfg.imperativeConfig) then
          lib.mkForce { }
        else
          {
            logo.source = cfg.image;
          };
      # ok so long story here. To redirect the fastfetch shell command to the image randomizer script I must set cfg.package using symlinkJoin
      # if using symlinkJoin to link "fastfetch" to the script and adding to home.packages, HM throws a fit about a collision
      # doing it this way works well but with the only downside of being unable to set your fastfetch version when using the image randomizer option
      package = lib.mkIf cfg.imageRandomizer.enable (
        lib.mkForce (
          pkgs.symlinkJoin {
            name = "fastfetch";
            paths = [ (image-randomizer) ];

            postBuild = ''
              rm -f $out/bin/fastfetch
              ln -s $out/bin/ff-image-randomizer $out/bin/fastfetch
            '';
          }
        )
      );
    };
  };
}
