{ displayManager, lib, ... }:
let
  sddm = (displayManager == "sddm");
  gdm = (displayManager == "gdm");
in
{
  imports =
    (lib.optionals sddm [ ./sddm ]) ++
    (lib.optionals gdm [ ./gdm ]);
}
