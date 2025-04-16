{ lib, ... }:
let
  inherit (lib) autoImport;
  programs = autoImport ./programs;
in
{
  imports = programs;
}
