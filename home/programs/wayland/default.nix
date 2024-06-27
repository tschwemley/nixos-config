{pkgs, ...}:
# Wayland config
{
  imports = [
    ./hyprland
  ];

  home.packages = with pkgs; [
    cliphist
    grim
    # slurp

    # utils
    # TODO: this looks kind of interesting... check to see if this is worth looking into copying
    # self.packages.${pkgs.system}.wl-ocr
    wl-clipboard
    wlr-randr
    wf-recorder # records screen
    ydotool
  ];

  home.sessionVariables = {
    # tells gtk to use wayland, falling back if unavailable
    GDK_BACKEND = "wayland,x11";

    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_QPA_PLATFORM = "wayland;xcb"; # tells qt to use wayland, falling back if necessary
    QT_WAYLAND_DISABLE_WINDOW_DECORATION = "1";

    # make SDL2 applications use wayland
    SDL_VIDEODRIVER = "wayland";

    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    # see: https://wiki.archlinux.org/title/Wayland#GUI_libraries

    # TODO: possibly add these back? see if necessary w/ cursor behavior
    # "KWIN_FORCE_SW_CURSOR,1"
    # "WLR_NO_HARDWARE_CURSORS,1"
  };

  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-wlr];
}
