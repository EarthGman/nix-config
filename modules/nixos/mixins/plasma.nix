{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.plasma;
in
{
  options.gman.plasma.enable = lib.mkEnableOption "gman's plasma 6 configuration";

  config = lib.mkIf cfg.enable {
    services = {
      desktopManager.plasma6 = {
        enable = true;
      };

      # ensure sddm is enabled
      displayManager.sddm.enable = true;
    };

    # modifying sddm does not play well with plasma
    meta.profiles.sddm = lib.mkOverride 899 "";

    environment = {
      plasma6.excludePackages = builtins.attrValues {
        inherit (pkgs.kdePackages)
          elisa
          khelpcenter
          kinfocenter
          ;
      };
    };

    # plasma does not come with a calculator
    programs = {
      kalk.enable = true;

      # disable the default gnome frontend in favor of KDE discover
      gnome-software.enable = lib.mkOverride 899 false;

      # disable pwvucontrol in favor of the default plasma volume control
      pwvucontrol.enable = lib.mkOverride 899 false;
    };
  };
}
