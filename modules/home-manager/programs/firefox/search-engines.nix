{ pkgs, outputs, ... }:
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
      template = "https://www.nixhub.io/search?q={searchTerms}";
    }];
    icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake-white.svg";
    definedAliases = [ "@nh" ];
  };
  "Nixos Options" = {
    urls = [{
      template = "https://search.nixos.org/options?query={searchTerms}";
    }];
    icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
    definedAliases = [ "@no" ];
  };
  "Noogle.dev" = {
    urls = [{
      template = "https://noogle.dev/q?term={searchTerms}";
    }];
    icon = outputs.icons.lambda;
    definedAliases = [ "@ngd" ];
  };
}
