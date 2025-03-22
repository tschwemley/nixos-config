{config, ...}: {
  # For all settings available see: https://wiki.hyprland.org/Configuring/Variables/
  wayland.windowManager.hyprland.settings = {
    debug.disable_logs = false;

    cursor = {
      inactive_timeout = 4;
      min_refresh_rate = 240;
      no_break_fs_vrr = true;
      no_hardware_cursors = true;
    };

    ecosystem = {
      no_donation_nag = true;
      no_update_news = true;
    };

    exec-once = [
      "wl-paste --watch cliphist store"
    ];

    general = {
      gaps_out = 10;
      layout = "dwindle"; # defaults: dwindle, master
    };

    gestures = {
      workspace_swipe = true;
    };

    input = {
      follow_mouse = 1;
    };

    # see: https://wiki.hyprland.org/Configuring/Master-Layout/
    master = {
      mfact = 0.40;
      orientation = "center";
      slave_count_for_center_master = 0;
    };

    misc = {
      # disable the cringe anime background
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      force_default_wallpaper = 0;
    };

    monitor = config.hyprland.monitors.config;

    render = {
      # direct scanout attempts to reduce lag when there is only one fullscreen application on a screen
      direct_scanout = true;
    };

    workspace = config.hyprland.workspaces;

    xwayland.force_zero_scaling = true;
  };
}
