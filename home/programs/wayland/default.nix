{pkgs, ...}:
# Wayland config
{
  imports = [./waybar];

  home = {
    packages = with pkgs; [
      cliphist
      grim # TODO: are grimblast and grim both needed?
      slurp # TODO: I don't remember what slurp does/if it's necessary anymore

      # utils
      wl-clipboard
      wl-ocr
      wf-recorder
      ydotool # TODO: still need?
    ];

    sessionVariables = {
      MOZ_ENABLE_WAYLAND = 1;

      # make SDL2 applications use wayland
      SDL_VIDEODRIVER = "wayland";
      XDG_SESSION_TYPE = "wayland";
    };
  };
}
