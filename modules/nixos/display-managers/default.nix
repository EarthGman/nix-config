{ displayManager, lib, ... }:
let
  sddm = if (displayManager == "sddm") then true else false;
  gdm = if (displayManager == "gdm") then true else false;
in
{
  imports =
    (lib.optionals sddm [ ./sddm ]) ++
    (lib.optionals gdm [ ./gdm ]);
}
