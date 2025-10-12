{ pkgs, ... }:
# Wayland config
{
  imports = [ ./waybar ];

  home = {
    packages = with pkgs; [
      cliphist
      # utility that gives x,y && w x h coordinates for a selection
      slurp
      wl-clipboard
      wl-ocr
      wf-recorder
      wlr-randr
      ydotool
    ];

    sessionVariables = {
      MOZ_ENABLE_WAYLAND = 1;

      # make SDL2 applications use wayland
      SDL_VIDEODRIVER = "wayland";
      XDG_SESSION_TYPE = "wayland";
    };
  };
}
