{ pkgs, config, hostName, ... }:
let
  t = "$" + "{THEMES[@]}";
in
pkgs.writeScript "theme-switcher.sh" ''

    THEMES=("april" "inferno" "headspace" "ashes" "vibrant-cool" )

    THEME=$(printf "%s\n" "${t}" | rofi -dmenu -i -p "Search" )
  if [ -z "$THEME" ]; then
      exit 0
  fi

  sed -i -E "s|(theme = self \+ /modules/home-manager/desktop-configs/themes/).*|\1$THEME.nix;|" ${config.home.homeDirectory}/src/nix-config/hosts/${hostName}/users/${config.home.username}/preferences.nix

  sudo nixos-rebuild test
  exit 0
''
