{
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
          "clock"
        ];

        "clock" = {
          interval = 1;
          format = "{:%H:%M:%S}";
        };

        pulseaudio = {
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" "" ""];
          };
          on-click = "pavucontrol";
          spacing = 4;
        };
      };

      systemd.enable = true;
    };

    style = ./style.css;
  };
}
