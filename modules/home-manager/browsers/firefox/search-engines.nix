{ pkgs, ... }:
{
  "Nix Packages" = {
    urls = [{
      template = "https://search.nixos.org/packages?query={searchTerms}";
    }];
    icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
    definedAliases = [ "@np" ];
  };
  "Home Manager Options" = {
    urls = [{
      template = "https://home-manager-options.extranix.com/options.html?query={searchTerms}";
    }];
    icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake-white.svg";
    definedAliases = [ "@hm" ];
  };
  "Nix Hub" = {
    urls = [{
      template = "https://www.nixhub.io/?query={searchTerms}";
    }];
    icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake-white.svg";
    definedAliases = [ "@nh" ];
  };
}
