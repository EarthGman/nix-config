{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.programs.i3lock.settings;
in
pkgs.writeScriptBin "i3lock" ''
  ${lib.getExe pkgs.i3lock} \
  ${if cfg.image != "" then "-i ${cfg.image}" else ""} \
  -c ${cfg.color} \
  ${if cfg.noFork then "-n" else ""} \
  ${if cfg.beep then "-b" else ""} \
  ${if cfg.noUnlockIndicator then "-u" else ""} \
  ${if cfg.tiling then "-t" else ""} \
  ${if cfg.windowsPointer then "-p win" else "-p default"} \
  ${if cfg.ignoreEmptyPassword then "-e" else ""} \
  ${if cfg.showFailedAttempts then "-f" else ""} \
  ${if cfg.showKeyboardLayout then "-k" else ""} \
''
