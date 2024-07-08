{ pkgs, ... }:
{
  "Nix Packages" = {
    urls = [{
      template = "https://search.nixos.org/packages?query={searchTerms}";
    }];
    icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
    definedAliases = [ "@np" ];
  };
  "HM options" = {
    urls = [{
      template = "https://home-manager-options.extranix.com/options.html?query={searchTerms}";
    }];
    icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake-white.svg";
    definedAliases = [ "@hm" ];
  };
}
