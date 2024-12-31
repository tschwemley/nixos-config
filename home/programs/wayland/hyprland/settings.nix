{config, ...}: {
  wayland.windowManager.hyprland.settings = {
    debug.disable_logs = false;

    cursor = {
      inactive_timeout = 4;
      min_refresh_rate = 240;
      no_break_fs_vrr = true;
      no_hardware_cursors = true;
    };

    exec-once = [
      "wl-paste --watch cliphist store"
    ];

    general = {
      gaps_out = 10;
      # layout = "master";
      layout = "hy3";
    };

    gestures = {
      workspace_swipe = true;
    };

    # input = {
    #   follow_mouse = 2;
    # };

    # see: https://wiki.hyprland.org/Configuring/Master-Layout/
    master = {
      always_center_master = true;
      mfact = 0.40;

      orientation = "center";
    };

    misc = {
      # disable the stupid default anime background
      disable_hyprland_logo = true;
      force_default_wallpaper = 0;
    };

    monitor = config.hyprland.monitors.config;

    render = {
      # direct scanout attempts to reduce lag when there is only one fullscreen application on a screen
      direct_scanout = true;
    };

    workspace = config.hyprland.workspaces;
  };
}
