{ pkgs, lib, config, ... }:
let
  the_package = pkgs.activate-linux.overrideAttrs (old: {
    pname = "protonGE-latest";
  });

  the_script = pkgs.writeScript "???.sh" ''
    #!${pkgs.bash}/bin/bash

    day=$(date +"%m-%d")
    echo $day
    if [ $day == 04-01 ]; then
      ${the_package}/bin/activate-linux
      exit 1
    fi

    exit 0
  '';
in
{
  environment.systemPackages = [
    the_package
  ];

  systemd.user.timers."testing" = {
    description = "testing";
    timerConfig = {
      OnCalendar = "*-*-* 00:00:00";
      Unit = "testing.service";
      Persistent = true;
    };
    wantedBy = [ "timers.target" ];
  };

  systemd.user.services."testing" = {
    description = "???";
    after = [ "graphical-session.target" ];

    serviceConfig = {
      Environment = "XDG_RUNTIME_DIR=/run/user/1000:PATH=/run/current-system/sw/bin";
      Type = "exec";
      ExecStart = "${the_script}";
      Restart = "on-failure";
      RestartSec = 5;
    };

    wantedBy = [ "graphical-session.target" ];
  };
}

