{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        lock_cmd = "hyprlock";
      };

      listener = [
        {
          timeout = 2700; # 45 mins
          on-timeout = "hyprlock";
        }
        {
          timeout = 3600; # 1 hour
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
