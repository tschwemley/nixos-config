{config, ...}: {
  wayland.windowManager.hyprland.settings = {
    debug.disable_logs = false;

    cursor = {
      inactive_timeout = 4;
      min_refresh_rate = 240;
      no_break_fs_vrr = true;
      no_hardware_cursors = true;
    };

    decoration.blur.enabled = false; # TODO: remove this if it doesn't do anything to help solve issues

    exec-once = [
      "wl-paste --watch cliphist store"
    ];

    general = {
      gaps_out = 10;
      layout = "dwindle";
    };

    gestures = {
      workspace_swipe = true;
    };

    master = {
      # for all options see: https://wiki.hyprland.org/Configuring/Master-Layout/
      always_center_master = true;
      orientation = "center";
    };

    misc = {
      # disable the stupid default anime background
      disable_hyprland_logo = true;
      force_default_wallpaper = 0;

      # TODO: highly recommended to keep true... switch to false to at least test once if causing issues
      # vfr = false;
    };

    monitor = config.hyprland.monitors.config;

    render = {
      # direct scanout attempts to reduce lag when there is only one fullscreen application on a screen
      direct_scanout = true;
    };

    # TODO: remove or revisit plugins
    plugin = {
      # easymotion = {
      #   textsize = 20;
      #   textcolor = "rgba(43ff64d9)";
      #   textfont = "Hasklig";
      # };
    };

    workspace = config.hyprland.workspaces;
  };
}
