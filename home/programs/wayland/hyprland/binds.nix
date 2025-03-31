{
  config,
  lib,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";

    bind = let
      # map over workspaces && return a list of the binds for moving apps/switching to
      # we also flatten since we're merging into the bind attr
      workspaceBinds =
        lib.lists.flatten
        (
          lib.lists.imap0 (
            k: _: let
              num = builtins.toString (k + 1);
            in [
              "$mod, ${num}, workspace, ${num}"
              "$mod shift, ${num}, movetoworkspacesilent, ${num}"
            ]
          )
          config.hyprland.workspaces
        );
    in
      [
        # application launching
        "$mod, p, exec, wofi --show drun"
        "$mod, Return, exec, ${pkgs.wezterm}/bin/wezterm"

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
        "$mod alt, f, togglefloating, active"
        "$mod shift, f, fullscreen, 1"
        "$mod shift, h, movewindow, mon:1"
        "$mod shift, l, movewindow, mon:0"
      ]
      ++ workspaceBinds
      ++ config.hyprland.pluginBinds;

    # mouse binds
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
      "$mod ALT, mouse:272, resizewindow"
    ];
  };
}
