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
      # QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_QPA_PLATFORM = "wayland";
      # QT_WAYLAND_DISABLE_WINDOW_DECORATION = "1";

      # make SDL2 applications use wayland
      SDL_VIDEODRIVER = "wayland";

      XDG_SESSION_TYPE = "wayland";
      # see: https://wiki.archlinux.org/title/Wayland#GUI_libraries
    };
  };
}
