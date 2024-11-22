{pkgs, ...}: {
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";

    bind = [
      # application launching
      "$mod, p, exec, wofi --show drun"
      "$mod, Return, exec, ${pkgs.kitty}/bin/kitty"

      # clipboard, ocr, and screenshot
      "$mod, V, exec, cliphist list | wofi -dmenu | cliphist decode | wl-copy"
      "$mod, o, exec, wl-ocr"
      "$mod $shift, s, exec, grimblast --notify copysave area"

      # window management
      "alt, tab, cyclenext"
      "alt shift, tab, cyclenext, prev"
      "$mod, l, layoutmsg, swapnext"
      "$mod, h, layoutmsg, swapprev"
      "$mod, w, killactive"
      "$mod shift, f, fullscreen, 1"
      "$mod shift, h, movewindow, mon:1"
      "$mod shift, l, movewindow, mon:0"

      # workspaces
      "$mod, 1, workspace, 1"
      "$mod, 2, workspace, 2"
      "$mod, 3, workspace, 3"
      "$mod, 4, workspace, 4"
      "$mod, 5, workspace, 5"
      "$mod, 6, workspace, 6"
      "$mod, 7, workspace, 7"
      "$mod, 8, workspace, 8"

      "$mod shift, 1, movetoworkspace, 1"
      "$mod shift, 2, movetoworkspace, 2"
      "$mod shift, 3, movetoworkspace, 3"
      "$mod shift, 4, movetoworkspace, 4"
      "$mod shift, 5, movetoworkspace, 5"
      "$mod shift, 6, movetoworkspace, 6"
      "$mod shift, 7, movetoworkspace, 7"
      "$mod shift, 8, movetoworkspace, 8"

      # "$mod, z, easymotion, action:hyprctl dispatch focuswindow address:{}"
    ];

    # mouse binds
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
      "$mod ALT, mouse:272, resizewindow"
    ];
  };
}
