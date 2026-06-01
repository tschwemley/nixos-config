{ pkgs, ... }:
{
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;

    config = {
      common.default = [
        "gtk"
      ];
      niri.default = [
        "gtk"
      ];
    };

    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };
}
