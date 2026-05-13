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
      # hyprland.default = [
      #   "gtk"
      #   "hyprland"
      # ];
    };

    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };
}
