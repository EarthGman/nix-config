{ pkgs, ... }:
pkgs.writeShellScript "idle-daemon-event-handler.sh" ''
  EVENT_CMD=$1
  REQUESTED_POWER_STATE=$2
  AC_PATH="/sys/class/power_supply/AC"
  CURRENT_POWER_STATE="1"

  check_power_state() {
    if [ -f $AC_PATH/online ]; then
      if [ $(cat $AC_PATH/online) == "0" ]; then
        CURRENT_POWER_STATE="0"
      fi
    fi
  }

  check_power_state
  if [[ $CURRENT_POWER_STATE == $REQUESTED_POWER_STATE ]]; then
    2>/dev/null 1>&2 $EVENT_CMD
    exit 0
  fi
  exit 0
''
