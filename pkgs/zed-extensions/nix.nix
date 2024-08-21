{ rustPlatform, pkgs }:
let
  pname = "zed-nix-extension";
  version = "1.0";
in
rustPlatform.buildRustPackage {
  inherit pname version;

  src = pkgs.fetchFromGitHub {
    owner = "zed-extensions";
    repo = "nix";
    rev = "242631811daee74d5ee26be36a067e4033e88bd3";
    hash = "sha256-IMpyh6xlycUCVr7bmN3BjhuxksSxRiq5DB/XZMlipcM=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
  };
}
