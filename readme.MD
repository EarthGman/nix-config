TODO:
1. allow for the selection of 1 or more desktop environments.
  desktop is null by default / not a workstation or gamestation
  pass an array or set of desktops to the helper functions for nixos and HM
  returns the array of desktops to enable to use throughout configuration
  enumerate through the array enabling desktops if they exist within it
  allow the user to set a default desktop for the system

2. display manager theming 
  display manager defaults to sddm
  allow the user to select a theme for sddm if it is enabled