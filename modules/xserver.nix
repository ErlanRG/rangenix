{ ... }:

{
  services = {
    xserver = {
      enable = true;
      windowManager.i3.enable = true;
    };
    displayManager = { defaultSession = "none+i3"; };
  };
  security.pam.services = {
    i3lock.enable = true;
    i3lock-color.enable = true;
    xscreensaver.enable = true;
  };
}
