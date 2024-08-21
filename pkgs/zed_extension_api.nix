{ rustPlatform, fetchCrate, lib }:
let
  pname = "zed_extension_api";
  version = "0.1.0";
in
rustPlatform.buildRustPackage {
  inherit pname version;

  src = fetchCrate {
    inherit pname version;
    # sha256 = "sha256-e+ZBbo2fEi26Z2PpNinDjP4F/uGRSc3A//nxye4KfbI=";
  };
}
