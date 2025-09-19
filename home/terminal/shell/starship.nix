{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      # "$schema" = "https://starship.rs/config-schema.json";

      format = "$hostname$username$directory$git_branch$git_status$time$line_break$character";
      line_break.disabled = false;
      os.disabled = true;
      palette = "gruvbox_dark";

      character = {
        disabled = false;
        error_symbol = "[](bold fg:color_red)";
        success_symbol = "[](bold fg:color_green)";
        vimcmd_replace_one_symbol = "[](bold fg:color_purple)";
        vimcmd_replace_symbol = "[](bold fg:color_purple)";
        vimcmd_symbol = "[](bold fg:color_green)";
        vimcmd_visual_symbol = "[](bold fg:color_yellow)";
      };

      directory = {
        format = "[$path ]($style)";
        style = "color_yellow";
        substitutions = {
          Developer = "󰲋 ";
          Documents = "󰈙 ";
          Downloads = " ";
          Music = "󰝚 ";
          Pictures = " ";
        };
        truncation_length = 3;
        truncation_symbol = "…/";
      };

      docker_context = {
        format = "[[ $symbol( $context) ](fg:#83a598 bg:color_bg3)]($style)";
        style = "bg:color_bg3";
        symbol = "";
      };

      git_branch = {
        format = "[$symbol $branch ]($style)";
        style = "color_aqua";
        symbol = "";
      };

      git_status = {
        format = "[$all_status$ahead_behind ]($style)";
        style = "color_aqua";
      };

      golang = {
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
        style = "bg:color_blue";
        symbol = "";
      };

      hostname = {
        disabled = false;
        format = "[$ssh_symbol ](bold blue) on [$hostname](bold red) ";
        ssh_only = true;
        ssh_symbol = "󰣀";
        trim_at = ".companyname.com";
      };

      nodejs = {
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
        style = "bg:color_blue";
        symbol = "";
      };

      palettes = {
        gruvbox_dark = {
          color_aqua = "#689d6a";
          color_bg1 = "#3c3836";
          color_bg3 = "#665c54";
          color_blue = "#458588";
          color_fg0 = "#fbf1c7";
          color_green = "#98971a";
          color_orange = "#d65d0e";
          color_purple = "#b16286";
          color_red = "#cc241d";
          color_yellow = "#d79921";
        };
      };

      time = {
        disabled = false;
        time_format = "";
      };

      username = {
        format = "[$user ]($style)";
        show_always = true;
        style_root = "color_orange";
        style_user = "color_orange";
      };
    };
  };
}
