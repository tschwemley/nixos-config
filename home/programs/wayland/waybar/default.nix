{
  self,
  pkgs,
  ...
}:
{
  home.packages = [
    pkgs.wttrbar

    self.packages.${pkgs.stdenv.hostPlatform.system}.pomobar-rs
  ];

  programs.waybar = {
    enable = true;

    # REF: https://github.com/Alexays/Waybar/wiki/Configuration
    settings = {
      statusBar = {
        modules-left = [
          "niri/workspaces"
        ];

        modules-center = [
          "niri/window"
        ];

        modules-right = [
          "pulseaudio"
          "pulseaudio/slider"
          "gamemode"
          "tray"
          "battery"
          "custom/weather"
          "clock"
        ];

        battery = {
          interval = 60;
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
          max-length = 25;
        };

        clock = {
          actions = {
            on-click-right = "mode";
            on-scroll-down = "shift_down";
            on-scroll-up = "shift_up";
          };
          calendar = {
            format = {
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              months = "<span color='#ffead3'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
            };
            mode = "month";
            # on-scroll = 1;
            # weeks-pos = "right";
          };
          format = "{:%H:%M}  ";
          format-alt = "{:%A, %B %d, %Y (%R)}  ";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
        };

        # "custom/pomobar" = {
        #   format = "{} {icon}";
        #   format-icons = {
        #     idle = "";
        #     paused = "";
        #     work = "";
        #     short_break = "";
        #     long_break = "";
        #   };
        #   interval = 1;
        #   exec = "pomobar-cli status";
        #   on-click = "pomobar-cli toggle";
        #   on-click-middle = "pomobar-cli reset";
        #   return-type = "json";
        # };

        "custom/weather" = {
          format = "{}°";
          tooltip = true;
          interval = 3600;
          exec = "wttrbar --fahrenheit --location 48197 --nerd";
          return-type = "json";
        };

        gamemode = {
          # hide-not-running = true;
          format = "{glyph}";
          format-alt = "{glyph} {count}";
          glyph = "";
          hide-not-running = false;
          icon-size = 20;
          icon-spacing = 4;
          tooltip = true;
          tooltip-format = "Games running: {count}";
          use-icon = false;
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
            default = [
              ""
              ""
              ""
            ];
            headphone = "";
            headset = "";
            phone = "";
            portable = "";
          };
          on-click = "pavucontrol";
          spacing = 4;
        };

        "pulseaudio/slider" = {
          min = 0;
          max = 100;
          orientation = "horizontal";
        };

        # tray = {};
        tray = {
          spacing = 10;
        };
      };
    };

    style = ./style.css;
    systemd.enable = true;
  };
}
