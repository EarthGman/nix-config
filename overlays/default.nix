{
  # brings custom packages from pkgs folder into pkgs
  additions = final: _prev: import ../pkgs { pkgs = final; };
}
