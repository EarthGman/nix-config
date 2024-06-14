{ users, ... }:
let
  usernames = builtins.filter builtins.isString (builtins.split "," users);
in
{
  # enables xremap to be used in the user space by HM
  hardware.uinput.enable = true;
  users.groups = {
    uinput.members = usernames;
    input.members = usernames;
  };
}
