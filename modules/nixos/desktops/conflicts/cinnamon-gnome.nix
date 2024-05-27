{ lib, ... }:
{
  environment.sessionVariables.NIX_GSETTINGS_OVERRIDES_DIR = lib.mkForce "/nix/store/bmn25wcr6rp682bkyvjsj7yddlln4ldv-cinnamon-gsettings-overrides/share/gsettings-schemas/nixos-gsettings-overrides/glib-2.0/schemas";
  # alternatively
  # environment.sessionVariables.NIX_GSETTINGS_OVERRIDES_DIR = lib.mkForce "/nix/store/s3gvgawfp8przz0r6rvz5i1avn7i2x54-gnome-gsettings-overrides/share/gsettings-schemas/nixos-gsettings-overrides/glib-2.0/schemas";
}
