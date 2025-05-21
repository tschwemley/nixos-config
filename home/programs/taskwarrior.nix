{
  config,
  pkgs,
  ...
}: let
  package = pkgs.taskwarrior3;
in {
  home.packages = with pkgs; [
    tasknc
    taskopen
    tasksh
    taskwarrior-tui
    vit
  ];

  programs.taskwarrior = {
    inherit package;
    enable = true;

    config = {};

    extraConfig =
      /*
      ini
      */
      ''
        include ${config.xdg.dataFile."task/gruvbox.theme".source}
      '';
  };

  services.taskwarrior-sync = {
    inherit package;
    enable = true;
    frequency = "*:0/30";
  };

  xdg.dataFile."task/gruvbox.theme".text =
    /*
    bash
    */
    ''
      # Gruvbox Dark Material Hard Theme for Taskwarrior

      # Based on:
      # https://github.com/mbadolato/iTerm2-Color-Schemes/blob/master/wezterm/GruvboxDarkMaterialHard.toml

      # Background and Foreground
      color.bg = color0  # #1d2021 (ansi[0])
      color.fg = color7  # #d4be98 (ansi[7])

      # Basic Task Information
      color.header = color6  # #89b482 (ansi[6])
      color.footer = color6  # #89b482 (ansi[6])
      color.label = color4  # #7daea3 (ansi[4])
      color.uda.label = color4  # #7daea3 (ansi[4])
      color.uda.value = color7  # #d4be98 (ansi[7])

      # Status Colors
      color.pending = color7  # #d4be98 (ansi[7])
      color.completed = color2  # #a9b665 (ansi[2])
      color.deleted = color1  # #ea6962 (ansi[1])
      color.waiting = color3  # #d8a657 (ansi[3])
      color.recurring = color5  # #d3869b (ansi[5])

      # Priorities
      color.priority.H = color1  # #ea6962 (ansi[1])
      color.priority.M = color3  # #d8a657 (ansi[3])
      color.priority.L = color6  # #89b482 (ansi[6])

      # Tags and Projects
      color.tag = color4  # #7daea3 (ansi[4])
      color.tag.active = color4  # #7daea3 (ansi[4])
      color.project = color6  # #89b482 (ansi[6])
      color.project.parent = color6  # #89b482 (ansi[6])
      color.project.children = color6  # #89b482 (ansi[6])

      # Dependencies and Annotations
      color.dependency = color1  # #ea6962 (ansi[1])
      color.annotation = color5  # #d3869b (ansi[5])

      # Overdue and Due Soon
      color.overdue = color1  # #ea6962 (ansi[1])
      color.due = color3  # #d8a657 (ansi[3])

      # Scheduled and Until
      color.scheduled = color5  # #d3869b (ansi[5])
      color.until = color5  # #d3869b (ansi[5]) # Using same as scheduled for consistency

      # Active Task (Highlighting)
      color.active = color4 on color0  # #7daea3 on #1d2021

      # Grid Lines
      color.grid = color7  # #d4be98 (ansi[7])
      color.grid.black = color0  # #1d2021 (ansi[0])
      color.grid.red = color1  # #ea6962 (ansi[1])
      color.grid.green = color2  # #a9b665 (ansi[2])
      color.grid.yellow = color3  # #d8a657 (ansi[3])
      color.grid.blue = color4  # #7daea3 (ansi[4])
      color.grid.magenta = color5  # #d3869b (ansi[5])
      color.grid.cyan = color6  # #89b482 (ansi[6])
      color.grid.white = color7  # #d4be98 (ansi[7])

      # Odd/Even Row Shading (Optional, uncomment to use)
      # color.alt = color0  # #1d2021 (ansi[0])

      # Important Message
      color.warning = color1  # #ea6962 (ansi[1])
      color.error = color1  # #ea6962 (ansi[1])
      color.nocolor = color7  # #d4be98 (ansi[7])

      # Column Specific Colors
      color.column.minor = color4  # #7daea3 (ansi[4])
      color.column.major = color7  # #d4be98 (ansi[7])

      # Report Specific Colors
      color.report.bg = color0  # #1d2021 (ansi[0])
      color.report.fg = color7  # #d4be98 (ansi[7])

      # Debug Colors (Usually not needed for users)
      # color.debug = color3  # #d8a657 (ansi[3])

      # Specific Colors from the brights palette (can be used for specific elements if needed)
      # color.bright.gray = color8  # #eddeb5 (brights[0])
      # color.bright.red = color9  # #ea6962 (brights[1]) - Same as ansi red
      # color.bright.green = color10 # #a9b665 (brights[2]) - Same as ansi green
      # color.bright.yellow = color11 # #d8a657 (brights[3]) - Same as ansi yellow
      # color.bright.blue = color12 # #7daea3 (brights[4]) - Same as ansi blue
      # color.bright.magenta = color13 # #d3869b (brights[5]) - Same as ansi purple
      # color.bright.cyan = color14 # #89b482 (brights[6]) - Same as ansi aqua
      # color.bright.white = color15 # #d4be98 (brights[7]) - Same as ansi white
    '';
}
