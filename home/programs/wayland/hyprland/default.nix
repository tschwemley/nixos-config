{
  inputs,
  pkgs,
  ...
}:
#let
# inherit (inputs.split-monitor-workspaces.packages.${pkgs.system}) split-monitor-workspaces;
#in {
{
  # ../../../programs/ags
  # ../../../services/dunst.nix
  imports = [
    ./binds.nix
    ./rules.nix
  ];

  home.packages = with pkgs; [
    clipman
    # grim # grab images
    # grimblast # grab images
    hyprpaper # wallpaper
    hyprpicker #color picker
    hyprshot #screenshot
    # slurp # select a region (used in conjunction w/ grim)
  ];

  # make stuff work on wayland
  home.sessionVariables = {
    GDK_BACKEND = "wayland,x11";
    GDK_SCALE = 1.25;
    QT_QPA_PLATFORM = "wayland;xcb";
    SDL_VIDEODRIVER = "wayland";
    XCURSOR_SIZE = 32;
    XDG_CURRENT_DESKTOP = "sway";
    XDG_SESSION_TYPE = "wayland";
  };

  wayland.windowManager.hyprland = {
    enable = true;

    extraConfig = ''
      general {
        layout = master
      }

      master {
        new_is_master = false
        orientation = right
      }

      # plugin {
      #   split-monitor-workspaces {
      #       count = 5
      #   }
      # }

      # unscale XWayland
      xwayland {
        force_zero_scaling = true
      }
    '';

    plugins = [
      # split-monitor-workspaces
    ];

    settings = {
      exec-once = [
        # "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "hyprpaper"
        "xrandr --output DP-2 --auto"
        "xrandr --output HDMI-A-2 --auto"
        "xrandr --output HDMI-A-2 --primary"
      ];

      monitor = [
        "HDMI-A-2,3840x2160@120,0x0,1"
        "DP-2,2560x2880@60,3840x0,1"
      ];

      workspace = [
        "1, monitor:HDMI-A-2"
        "2, monitor:DP-2"
        "3, monitor:HDMI-A-2"
        "4, monitor:DP-2"
      ];
    };

    systemd.enable = true;
  };

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload=/home/schwem/.config/hypr/dual-bg.jpg
    preload=/home/schwem/.config/hypr/lg-bg.jpg
    wallpaper=DP-2,/home/schwem/.config/hypr/dual-bg.jpg
    wallpaper=HDMI-A-2,/home/schwem/.config/hypr/lg-bg.jpg
  '';
}
