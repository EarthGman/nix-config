{
  modulesPath,
  ...
}@args:
let
  installer = if args ? installer then args.installer else false;
  desktop = if args ? desktop then args.desktop else null;
  installerProfile =
    if installer then
      if desktop == null then
        [ (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix") ]
      else
        [ (modulesPath + "/installer/cd-dvd/installation-cd-graphical-calamares.nix") ]
    else
      [ ];
in
{
  imports = installerProfile;
}
