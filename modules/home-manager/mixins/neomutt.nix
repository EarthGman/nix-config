{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.gman.neomutt.enable = lib.mkEnableOption "gman's neomutt configuration";

  config = lib.mkIf config.gman.neomutt.enable {
    programs.neomutt = {
      enable = true;
    };

    home.packages = builtins.attrValues {
      inherit (pkgs)
        mutt-wizard
        pass
        msmtp
        isync
        ;
    };
  };
}
