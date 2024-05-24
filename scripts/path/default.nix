{ config, pkgs, ... }:

let
  name = "path";
  inherit (pkgs) writeShellScriptBin symlinkJoin makeWrapper;
  scriptSrc = builtins.readFile ./${name}.sh;
  script = (writeShellScriptBin name scriptSrc).overrideAttrs (old: {
    buildCommand = ''
      ${old.buildCommand}
      patchShebangs $out
    '';
  });
  package = symlinkJoin {
    inherit name;
    paths = [ script ];
    buildInputs = [ makeWrapper ];
    postBuild = "wrapProgram $out/bin/${name} --prefix PATH : $out/bin";
  };
in
{
  home.packages = [ package ];
}
