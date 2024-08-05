{ pkgs, ... }:
{
  services = {
    blueman.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # searches for printers (allow port 5353)
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    printing.enable = true;

    # openVPN to resolve DNS hostnames
    resolved.enable = true;

    # connecting iphones via ifuse
    usbmuxd = {
      enable = true;
      package = pkgs.usbmuxd2;
    };

    sshd = {
      enable = true;
    };

    openssh = {
      enable = true;
      settings.PasswordAuthentication = true;
    };

    # permission error for dolphin GC adapters
    udev.packages = with pkgs; [ dolphinEmu ];
  };
}
