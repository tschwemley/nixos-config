{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      # "$schema" = "https://starship.rs/config-schema.json";

      format = "$hostname$username$directory$git_branch$git_status$time$line_break$character";
      line_break.disabled = false;
      os.disabled = true;

      #   # palette = "gruvbox_dark";
      #   # palette = "stylix";
      #
      character = {
        disabled = false;
        error_symbol = "[](bold fg:color_red)";
        success_symbol = "[](bold fg:color_green)";
        vimcmd_replace_one_symbol = "[](bold fg:color_purple)";
        vimcmd_replace_symbol = "[](bold fg:color_purple)";
        vimcmd_symbol = "[](bold fg:color_green)";
        vimcmd_visual_symbol = "[](bold fg:color_yellow)";
      };

      # directory = {
      #   format = "[$path ]($style)";
      #   style = "color_yellow";
      #   substitutions = {
      #     Developer = "󰲋 ";
      #     Documents = "󰈙 ";
      #     Downloads = " ";
      #     Music = "󰝚 ";
      #     Pictures = " ";
      #   };
      #   truncation_length = 3;
      #   truncation_symbol = "…/";
      # };
      #
      #   docker_context = {
      #     format = "[[ $symbol( $context) ](fg:#83a598 bg:color_bg3)]($style)";
      #     style = "bg:color_bg3";
      #     symbol = "";
      #   };
      #
      git_branch = {
        format = "[$symbol $branch ]($style)";
        style = "magenta";
        symbol = "";
      };
      #
      #   git_status = {
      #     format = "[$all_status$ahead_behind ]($style)";
      #     style = "color_aqua";
      #   };
      #
      #   golang = {
      #     format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      #     style = "bg:color_blue";
      #     symbol = "";
      #   };
      #
      hostname = {
        disabled = false;
        format = "[$ssh_symbol ](bold blue) on [$hostname](bold red) ";
        ssh_only = true;
        ssh_symbol = "󰣀";
        trim_at = ".companyname.com";
      };
      #
      #   nodejs = {
      #     format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      #     style = "bg:color_blue";
      #     symbol = "";
      #   };
      #
      #   time = {
      #     disabled = false;
      #     time_format = "";
      #   };
      #
      username = {
        format = "[$user ]($style)";
        show_always = true;
        style_root = "orange";
        style_user = "orange";
      };
    };
  };
}
