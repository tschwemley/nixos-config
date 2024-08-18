{pkgs, ...}:
# Wayland config
{
  home = {
    packages = with pkgs; [
      cliphist
      grim
      slurp

      # utils
      wl-clipboard
      wl-ocr
      wlr-randr
      wf-recorder # records screen
      ydotool
    ];

    sessionVariables = {
      # tells gtk to use wayland, falling back if unavailable
      GDK_BACKEND = "wayland,x11";

      # hints electron apps to use wayland
      NIXOS_OZONE_WL = "1";

      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_QPA_PLATFORM = "wayland;xcb"; # tells qt to use wayland, falling back if necessary
      QT_WAYLAND_DISABLE_WINDOW_DECORATION = "1";

      # make SDL2 applications use wayland
      SDL_VIDEODRIVER = "wayland";

      XDG_SESSION_TYPE = "wayland";
      # see: https://wiki.archlinux.org/title/Wayland#GUI_libraries
    };
  };
}
