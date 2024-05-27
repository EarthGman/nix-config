{ username, ... }:
{
  # enables xremap to be used in the user space by HM
  hardware.uinput.enable = true;
  users.groups = {
    uinput.members = [ username ];
    input.members = [ username ];
  };
}
