{ self, pkgs, ... }:
{
  imports = [
    ./services/hypridle.nix
    ./services/hyprlock.nix
  ];

  wayland.windowManager.hyprland = {
    plugins = with pkgs.hyprlandPlugins; [
      hyprscrolling

      # self.inputs.hyprland-easymotion.packages.${pkgs.system}.hyprland-easymotion

      # adds dispatchers: bringallfrom, closeunfocused, moveorexec, throwunfocused
      xtra-dispatchers

      # hy3
      # hyprexpo
      # hyprscroller
    ];

    settings.plugin = {
      # hy3 = {
      #   autotile = {
      #     enable = true;
      #     # trigger_width = 800;
      #     # trigger_height = 500;
      #   };
      # };

      # hyprexpo = {
      #   columns = 3;
      #   gap_size = 5;
      #   bg_col = "rgb(111111)";
      #   workspace_method = "center current"; # [center/first] [workspace] e.g. first 1 or center m+1
      #
      #   enable_gesture = true; # laptop touchpad
      #   gesture_fingers = 3; # 3 or 4
      #   gesture_distance = 300; # how far is the "max"
      #   gesture_positive = true; # positive = swipe down. Negative = swipe up.
      # };
    };
  };
}
