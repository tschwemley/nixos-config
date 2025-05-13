{
  services.hypridle = {
    enable = true;
    settings = let
      afterCmd = "systemctl --user waybar start && hyprctl dispatch dpms on";
      beforeCmd = "systemctl --user waybar stop && hyprctl dispatch dpms off";
    in {
      general = {
        # after_sleep_cmd = "hyprctl dispatch dpms on";
        after_sleep_cmd = afterCmd;
        lock_cmd = "hyprlock";
      };

      listener = [
        {
          timeout = 2700; # 45 mins
          on-timeout = "hyprlock";
        }
        {
          timeout = 3600; # 1 hour
          # on-timeout = "hyprctl dispatch dpms off";
          # on-resume = "hyprctl dispatch dpms on";
          on-timeout = beforeCmd;
          on-resume = afterCmd;
        }
      ];
    };
  };
}
