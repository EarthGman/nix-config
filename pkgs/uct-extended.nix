{ fetchurl, lib, stdenv }@args:
let
  buildFirefoxXpiAddon = lib.makeOverridable (
    { stdenv ? args.stdenv
    , fetchurl ? args.fetchurl
    , pname
    , version
    , addonId
    , url
    , sha256
    , meta
    , ...
    }:
    stdenv.mkDerivation {
      name = "${pname}-${version}";

      inherit meta;

      src = fetchurl { inherit url sha256; };

      preferLocalBuild = true;
      allowSubstitutes = true;

      passthru = { inherit addonId; };

      buildCommand = ''
        dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
        mkdir -p "$dst"
        install -v -m644 "$src" "$dst/${addonId}.xpi"
      '';
    }
  );
in
buildFirefoxXpiAddon {
  pname = "userchrome-toggle-extended";
  version = "1.5";
  addonId = "userchrome-toggle-extended@n2ezr.ru";
  url = "https://addons.mozilla.org/firefox/downloads/file/4295256/userchrome_toggle_extended-1.5.xpi";
  sha256 = "1r4pc6sbg54ig09niykljxgp9v4b3rahp7pn9hrbnhrmvbrphrr4";

  meta = with lib;
    {
      description = "Extended version of the UserChrome Toggle extension with additional features.";
      license = licenses.mit;
      mozPermissions = [ "notifications" "storage" ];
      platforms = platforms.all;
    };
}
