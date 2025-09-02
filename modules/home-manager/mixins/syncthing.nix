{ lib, config, ... }:
{
  options.gman.syncthing.enable = lib.mkEnableOption "gman's syncthing config";

  config = lib.mkIf config.gman.syncthing.enable (
    lib.mkMerge [
      {
        services.syncthing = {
          enable = true;
          settings = {
            urAccepted = "-1";
            devices = {
              cypher = {
                name = "cypher";
                id = "6Z42L5B-FBQ4MQH-MSSGLE4-SCSWL2Q-ASEWRIG-KGNP4RW-A4BXLKN-QRFE6AO";
              };
              think-one = {
                name = "think-one";
                id = "3IQNNM7-I2ASVNT-JHFFAWP-CNJWH34-NOGOXZG-WFL2LP6-4DI5RUV-LUUNWA7";
              };
              pixel-6a = {
                name = "pixel-6a";
                id = "HSMUIAY-VKYUTYG-HN56DRW-SKE3KNW-7DDOVEE-G3IN7NL-VPOEKCL-B35CVAZ";
              };
            };
            folders = {
              Documents = {
                label = "Documents";
                id = "gkd7f-fx7hm";
                path = "${config.home.homeDirectory}/Documents";
                devices = [
                  "cypher"
                  "think-one"
                ];
              };
              Picutres = {
                label = "Pictures";
                id = "palws-bqyki";
                path = "${config.home.homeDirectory}/Pictures";
                devices = [
                  "cypher"
                  "think-one"
                ];
              };
              Music = {
                label = "Music";
                id = "duqe5-9pujp";
                path = "${config.home.homeDirectory}/Music";
                devices = [
                  "cypher"
                  "think-one"
                  "pixel-6a"
                ];
              };
              Videos = {
                label = "Videos";
                id = "fwoxj-csvsx";
                path = "${config.home.homeDirectory}/Videos";
                devices = [
                  "cypher"
                  "think-one"
                ];
              };
              backups = {
                label = "Backups";
                id = "b6qms-k7hdh";
                path = "${config.home.homeDirectory}/backups";
                devices = [
                  "cypher"
                  "think-one"
                ];
              };
              src = {
                label = "Source";
                id = "jv7fa-c9tqt";
                path = "${config.home.homeDirectory}/src";
                devices = [
                  "cypher"
                  "think-one"
                ];
              };
              password-store = {
                label = "Passwords";
                id = "dspet-exglm";
                path = "${config.programs.password-store.settings.PASSWORD_STORE_DIR}";
                devices = [
                  "cypher"
                  "think-one"
                ];
              };
            };
          };
        };
      }
      (lib.mkIf (config.meta.desktop != "") {
        services.syncthing = {
          tray.enable = true;
        };
      })
    ]
  );
}
