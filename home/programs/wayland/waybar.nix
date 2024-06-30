let
  # based off of everforest colors. some colors I want to use aren't exposed by public gtk css vars
  # see: https://github.com/sainnhe/everforest/blob/master/palette.md
  colors = {
    purple = "#D699B6";
    blue = "#7FBBB3";
    aqua = "#83C092";
    green = "#A7C080";
    yellow = "#DBBC7F";
    orange = "#E69875";
    red = "#E67E80";
  };
in {
  programs.waybar = {
    enable = true;

    settings = {
      default = {
        clock = {
          interval = 1;
          format = "{:%H:%M:%S}  ";
          format-alt = "{:%A; %B %d; %Y (%R)}  ";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            on-click-right = "mode";
            on-click-forward = "tz_up";
            on-click-backward = "tz_down";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };
        cpu = {
          format = "CPU: {usage}%";
          format-critical = "CPU: <span color='${colors.red}'><b>{usage}%</b></span>";
          # format-high = "CPU: <span color='${colors.orange}'>{usage}%</span>";
          # format-medium = "CPU: <span color='${colors.green}'>{usage}%</span>";
          # format-low = "CPU: <span color='${colors.aqua}'>{usage}%</span>";
          tooltip = false;
          interval = 2;
          states = {
            critical = 80;
            high = 50;
            medium = 10;
            low = 0;
          };
        };
        "hyprland/window" = {
          max-length = 50;
        };
        layer = "top";
        memory = {
          format = "MEM: {used:0.1f}G/{total:0.1f}G ";
          # format-critical = "MEM: <span color='${colors.red}'><b>{used:0.1f}G/{total:0.1f}G </b></span>";
          # format-high = "MEM: <span color='${colors.orange}'>{used:0.1f}G/{total:0.1f}G </span>";
          # format-medium = "MEM: <span color='${colors.green}'>{used:0.1f}G/{total:0.1f}G </span>";
          # format-low = "MEM: <span color='${colors.aqua}'>{used:0.1f}G/{total:0.1f}G </span>";
          tooltip = false;
          interval = 2;
          states = {
            critical = 80;
            high = 50;
            medium = 10;
            low = 0;
          };
        };
        modules-left = [
          "hyprland/workspaces"
          "hyprland/submap"
        ];
        # "mpris"
        modules-center = [
          "hyprland/window"
        ];
        # "disk"
        # "temperature"
        modules-right = [
          "cpu"
          "memory"
          "network"
          "tray"
          "clock"
        ];
        network = {
          interface = "wlp2s0";
          format = "{ifname}";
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "{ipaddr}/{cidr} 󰊗";
          format-disconnected = ""; # An empty format will hide the module.
          tooltip-format = "{ifname} via {gwaddr} 󰊗";
          tooltip-format-wifi = "{essid} ({signalStrength}%) ";
          tooltip-format-ethernet = "{ifname} ";
          tooltip-format-disconnected = "Disconnected";
          max-length = 50;
        };
        spacing = 22;
        width = 2804;
      };
    };

    style = ''
      window#waybar {
          background: @theme_base_color;
          border-bottom: 1px solid @unfocused_borders;
          color: @theme_text_color;
      }

      .low {
        color: ${colors.aqua};
      }

      .medium {
        color: ${colors.green};
      }

      .high {
        color: ${colors.orange};
      }

      .critical {
        color: ${colors.red};
      }

      #cpu {
        /*margin: 0 8px;*/
      }

      #tray {
        /*margin: 0 8px;*/
      }
    '';
  };
}
