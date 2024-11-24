{ pkgs, vimUtils, ... }:

vimUtils.buildVimPlugin {
  name = "nvim-vauge";

  src = pkgs.fetchFromGitHub {
    owner = "vague2k";
    repo = "vague.nvim";
    rev = "ceeac4d04faaa83df542992098e01d893a20b5b3";
    sha256 = "10dk3vxdn7s2kaya0zqapls5dkl00qbdi3lzpxsjw0g1ga8cwdxz";
  };
}
