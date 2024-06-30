{pkgs, ...}: {
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";

    bind = [
      # TODO: organize these better and add comments for sections
      "$mod, Return, exec, ${pkgs.kitty}/bin/kitty"
      "$mod, p, exec, wofi --show drun"

      "$mod, 1, workspace, 1"
      "$mod, 2, workspace, 2"
      "$mod, 3, workspace, 3"
      "$mod, 4, workspace, 4"

      "$mod shift, 1, movetoworkspace, 1"
      "$mod shift, 2, movetoworkspace, 2"
      "$mod shift, 3, movetoworkspace, 3"
      "$mod shift, 4, movetoworkspace, 4"

      "alt, tab, layoutmsg, cyclenext"
      "alt shift, tab, layoutmsg, cycleprev"
      "$mod, l, layoutmsg, swapnext"
      "$mod, h, layoutmsg, swapprev"
      "$mod shift, h, movewindow, mon:1"
      "$mod shift, l, movewindow, mon:0"
      "$mod, w, killactive"

      "$mod, o, exec, wl-ocr"

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
