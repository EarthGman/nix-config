{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.qutebrowser;
in
{
  options.gman.qutebrowser = {
    enable = lib.mkEnableOption "gman's qutebrowser configuration";

    config = {
      enableDarkMode = lib.mkEnableOption "dark mode for gman's qutebrowser config";
    };
  };

  config = lib.mkIf cfg.enable {
    stylix.targets.qutebrowser.enable = true;
    gman.qutebrowser.config.enableDarkMode = (config.stylix.polarity == "dark");
    programs.qutebrowser = {
      loadAutoconfig = true;
      searchEngines = {
        w = "https://en.wikipedia.org/wiki/Special:Search?search={}&go=Go&ns0=1";
        aw = "https://wiki.archlinux.org/?search={}";
        nw = "https://wiki.nixos.org/index.php?search={}";
      };

      extraConfig = ''
        c.auto_save.session = True

        # tab style
        c.tabs.position = "left"
        c.tabs.padding = {'top': 5, 'bottom': 5, 'left': 9, 'right': 9}
        c.tabs.indicator.width = 0 # no tab indicators
        c.tabs.width = '10%'

        # keys
        config.bind('=', 'cmd-set-text -s :open')
        config.bind('h', 'history')
        config.bind('cs', 'cmd-set-text -s :config-source')
        config.bind('tH', 'config-cycle tabs.show always never')
        config.bind('sH', 'config-cycle statusbar.show always never')
        config.bind('T', 'hint links tab')
        config.bind('pP', 'open -- {primary}')
        config.bind('pp', 'open -- {clipboard}')
        config.bind('pt', 'open -t -- {clipboard}')
        config.bind('qm', 'macro-record')
        config.bind('<ctrl-y>', 'spawn --userscript ytdl.sh')
        config.bind('tT', 'config-cycle tabs.position top left')
        config.bind('gJ', 'tab-move +')
        config.bind('gK', 'tab-move -')
        config.bind('gm', 'tab-move')
      ''
      + lib.optionalString (cfg.config.enableDarkMode) ''
        # dark mode
        c.colors.webpage.darkmode.enabled = True
        c.colors.webpage.darkmode.algorithm = 'lightness-cielab'
        c.colors.webpage.darkmode.policy.images = 'never'
        config.set('colors.webpage.darkmode.enabled', False, 'file://*')
      '';

      greasemonkey = [
        (pkgs.writeText "yt-ads.js" ''
             // ==UserScript==
          // @name         Auto Skip YouTube Ads
          // @version      1.1.0
          // @description  Speed up and skip YouTube ads automatically
          // @author       jso8910 and others
          // @match        *://*.youtube.com/*
          // ==/UserScript==


          document.addEventListener('load', () => {
              const btn = document.querySelector('.videoAdUiSkipButton,.ytp-ad-skip-button-modern')
              if (btn) {
                  btn.click()
              }
              const ad = [...document.querySelectorAll('.ad-showing')][0];
              if (ad) {
                  document.querySelector('video').currentTime = 9999999999;
              }
          }, true);
        '')
      ];
    };
  };
}
