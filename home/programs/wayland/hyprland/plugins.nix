{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./services/hypridle.nix
    ./services/hyprlock.nix
  ];

  options = {
    hyprland.pluginBinds = lib.options.mkOption {
      # default = [];
      type = with lib.types; listOf string;
      readOnly = true;
    };
  };

  config = {
    hyprland.pluginBinds = [
      "SUPER, tab, hyprexpo:expo, toggle"
    ];

    wayland.windowManager.hyprland = {
      plugins = with pkgs.hyprlandPlugins; [
        hy3
        hyprexpo
        hyprgrass
        hyprscroller
      ];

      settings.plugin = {
        hy3 = {
          autotile = {
            enable = true;
            # trigger_width = 800;
            # trigger_height = 500;
          };
        };

        hyprexpo = {
          columns = 3;
          gap_size = 5;
          bg_col = "rgb(111111)";
          workspace_method = "center current"; # [center/first] [workspace] e.g. first 1 or center m+1

          enable_gesture = true; # laptop touchpad
          gesture_fingers = 3; # 3 or 4
          gesture_distance = 300; # how far is the "max"
          gesture_positive = true; # positive = swipe down. Negative = swipe up.
        };
      };
    };
  };
}
