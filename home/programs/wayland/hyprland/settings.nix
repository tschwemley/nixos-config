{
  wayland.windowManager.hyprland.settings = {
    env = ["QT_WAYLAND_DISABLE_WINDOWDECORATION,1"];

    exec-once = [
      # "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      "hyprpaper"
      "xrandr --output DP-2 --auto"
      "xrandr --output HDMI-A-2 --auto"
      "xrandr --output HDMI-A-2 --primary"
    ];

    general = {
      layout = "master";
    };

    master = {
      new_is_master = false;
      orientation = "right";
    };

    monitor = [
      "HDMI-A-2,3840x2160@120,0x0,1"
      "DP-2,2560x2880@60,3840x0,1"
    ];

    workspace = [
      "1, monitor:HDMI-A-2"
      "2, monitor:HDMI-A-2"
      "3, monitor:DP-2"
      "4, monitor:DP-2"
    ];
  };
}
