{
  wayland.windowManager.hyprland.settings = {
    debug.disable_logs = false;

    env = [
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      "KWIN_FORCE_SW_CURSOR,1"
      "WLR_NO_HARDWARE_CURSORS,1"
    ];

    exec-once = [
      "hyprpaper"
    ];

    general = {
      # layout = "dwindle";
      layout = "master";
      # layout = "scroller";
    };

    master = {
      # see: https://wiki.hyprland.org/Configuring/Master-Layout/
      new_is_master = false;
      orientation = "center";
    };

    misc = {
      #TODO: validate I want to keep these settings... they're copy/pasted
      # disable auto polling for config file changes
      # disable_autoreload = true;
      #
      # force_default_wallpaper = 0;

      # disable dragging animation
      # animate_mouse_windowdragging = false;

      # enable variable refresh rate (effective depending on hardware)
      # vrr = 1;

      # we do, in fact, want direct scanout
      # no_direct_scanout = false;
    };

    monitor = [
      # "HDMI-A-2,3840x2160@120,0x0,1" # LG C2
      # "DP-2,2560x2880@60,3840x0,1" # LG Dual Up
      "DP-1,5120x3440@240,0x0,1" # Odyssey g9
    ];

    plugin = {
      # easymotion = {
      #   textsize = 20;
      #   textcolor = "rgba(43ff64d9)";
      #   textfont = "Hasklig";
      # };
    };

    # xwayland.force_zero_scaling = true;

    workspace = [
      "1, monitor:DP-1"
      "2, monitor:DP-1"
      "3, onitor:DP-1"
      "4, monitor:DP-1"
      # "1, monitor:HDMI-A-2"
      # "2, monitor:DP-2"
      # "3, monitor:HDMI-A-2"
      # "4, monitor:DP-2"
    ];
  };
}
