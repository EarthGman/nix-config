{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.neomutt;
in
{
  options.gman.neomutt = {
    enable = lib.mkEnableOption "gman's neomutt configuration";
    config.mailsync = {
      enable = lib.mkOption {
        description = "whether to enable automatic mail sync with mutt wizard";
        type = lib.types.bool;
        default = true;
      };
      interval = lib.mkOption {
        description = "interval for mutt-wizard mailsync in seconds";
        type = lib.types.int;
        default = 60;
      };
    };
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        programs = {
          # address book
          abook.enable = true;

          password-store.enable = true;
          neomutt = {
            enable = true;
          };
        };

        home.packages = builtins.attrValues {
          inherit (pkgs)
            mutt-wizard
            msmtp
            isync
            ;
        };
        services.gpg-agent = {
          # set gpg-agent to 400 days so email sync doesn't prompt for password
          maxCacheTtl = 34560000;
        };

        # mutt wizard hardcodes the config files to the nix store.
        # so when the path changes due to a flake update your email accounts break, YAY
        # provide the required files in ~/.config/mutt/mutt-wizard for accounts to source
        xdg.configFile = {
          "mutt/mutt-wizard/mutt-wizard.muttrc".source =
            "${pkgs.mutt-wizard}/share/mutt-wizard/mutt-wizard.muttrc";
          "mutt/mutt-wizard/switch.muttrc".source = "${pkgs.mutt-wizard}/share/mutt-wizard/switch.muttrc";
        };
      }
      (lib.mkIf cfg.config.mailsync.enable {
        systemd.user = {
          timers."mw-mailsync" = {
            Unit = {
              Description = "mw-mailsync-timer";
            };
            Timer = {
              OnBootSec = toString cfg.config.mailsync.interval;
              OnUnitActiveSec = toString cfg.config.mailsync.interval;
            };
            Install = {
              WantedBy = [ "timers.target" ];
            };
          };
          services."mw-mailsync" = {
            Unit = {
              Description = "mutt-wizard mailsync";
            };
            Service = {
              Type = "oneshot";
              ExecStart = "${pkgs.mutt-wizard}/bin/mailsync";
            };
          };
        };
      })
    ]
  );
}
