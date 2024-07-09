{ browser, lib, ... }:
{
  imports =
    lib.optionals (browser == "firefox") [ ./firefox ];
}
