{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib)
    mkAfter
    mkEnableOption
    optionals
    mkOption
    mkIf
    types
    getExe
    mkForce
    ;
  cfg = config.programs.fastfetch;
in
{
  options.programs.fastfetch = {
    imperativeConfig = mkEnableOption "imperative config for fastfetch";
    image = mkOption {
      description = "image used for fastfetch";
      type = types.str;
      default = "nixos";
    };

    imageRandomizer.enable = mkEnableOption "fastfetch image randomization";

    imageRandomizer.images = mkOption {
      description = "list of image nix-paths that will be passed to the fastfetch randomizer";
      type = types.listOf types.str;
      default = [ cfg.image ]; # just in case its enabled but no images are provided
    };
  };

  config = mkIf cfg.enable {
    programs.fastfetch = {
      settings = (mkIf (cfg.imperativeConfig)) (mkForce { });
      # ok so long story here. To redirect the fastfetch shell command to the image randomizer script I must set cfg.package using symlinkJoin
      # if using symlinkJoin to link "fastfetch" to the script and adding to home.packages, HM throws a fit about a collision
      # doing it this way works well but with the only downside of being unable to set your fastfetch version when using the image randomizer option
      package = mkIf cfg.imageRandomizer.enable (
        mkForce (
          pkgs.symlinkJoin {
            name = "fastfetch";
            paths = [ (import ./image-randomizer.nix { inherit pkgs lib config; }) ];

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
