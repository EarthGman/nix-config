{ self, ... }:
{
  home.file."bin/path".source = self + /scripts/path.sh;
}
