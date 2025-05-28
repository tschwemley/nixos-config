{pkgs, ...}: {
  home.packages = [pkgs.wttrbar];

  programs.waybar = {
    enable = true;

    # REF: https://github.com/Alexays/Waybar/wiki/Configuration
    settings = {
      statusBar = {
        modules-left = [
          "hyprland/workspaces"
        ];

        modules-center = ["hyprland/window"];

        modules-right = [
          "pulseaudio"
          "pulseaudio/slider"
          "tray"
          "custom/weather"
          "clock"
        ];

        "clock" = {
          interval = 1;
          format = "{:%H:%M:%S}";
        };

        "custom/weather" = {
          format = "{}°";
          tooltip = true;
          interval = 3600;
          exec = "wttrbar --fahrenheit --location 48197 --nerd";
          return-type = "json";
        };

        pulseaudio = {
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            car = "";
            default = ["" "" ""];
            headphone = "";
            headset = "";
            phone = "";
            portable = "";
          };
          on-click = "pavucontrol";
          spacing = 4;
        };

        # tray = {};
        tray = {spacing = 10;};
      };
    };

    style = ./style.css;
    systemd.enable = true;
  };
}
