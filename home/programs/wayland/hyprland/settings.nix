{ config, ... }:
{
  wayland.windowManager.hyprland.settings = {
    # REF: https://wiki.hyprland.org/Configuring/Variables/

    debug.disable_logs = false;

    cursor = {
      inactive_timeout = 4;
      # min_refresh_rate = 120;
      # no_break_fs_vrr = true;
      # no_hardware_cursors = true;
    };

    ecosystem = {
      no_donation_nag = true;
      no_update_news = true;
    };

    exec-once = [
      "pypr"
      "wl-paste --watch cliphist store"
    ];

    # experimental.xx_color_management_v4 = true;

    general = {
      # allow_tearing = true;
      # allow_tearing = false;
      gaps_out = 8;
      # layout = "scrolling"; # defaults: dwindle, master
      layout = "dwindle"; # defaults: dwindle, master
    };

    # gestures = {
    #   workspace_swipe = true;
    # };

    input = {
      follow_mouse = 1;
    };

    # REF: https://wiki.hyprland.org/Configuring/Master-Layout/
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
      # vfr = false;
      vfr = true;
      vrr = 1;
    };

    monitor = config.hyprland.monitors.config;

    render = {
      # direct scanout attempts to reduce lag when there is only one fullscreen application on a screen
      direct_scanout = 1;
      # xp_mode = true;
      # new_render_scheduling = true;
    };

    workspace = config.hyprland.workspaces;
  };
}
