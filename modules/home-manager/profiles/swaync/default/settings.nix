{
  lib,
  ...
}:
let
  inherit (lib) mkDefault;
in
{
  positionY = mkDefault "bottom";
  fit-to-screen = mkDefault false;
  timeout = mkDefault 5;
  notification-window-width = 300;
  cssPriority = "user";
  image-size = 40;

  notification-body-image-height = 100;
  notification-body-image-width = 200;

  control-center-width = mkDefault 400;
  control-center-height = mkDefault 750;
  control-center-margin-bottom = mkDefault 20;
  control-center-margin-right = mkDefault 20;
  control-center-margin-left = mkDefault 0;
}
