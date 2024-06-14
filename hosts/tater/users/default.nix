{ users, lib, ... }:
let
  usernames = builtins.filter builtins.isString (builtins.split "," users);
in
{
  imports = lib.forEach usernames (username: ./. + /${username});
}
