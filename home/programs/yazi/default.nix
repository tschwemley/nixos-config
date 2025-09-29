{
  config,
  pkgs,
  ...
}:
let
  yaziGruvbox = pkgs.fetchFromGitHub {
    owner = "bennyyip";
    repo = "gruvbox-dark.yazi";
    rev = "e5e1aef";
    hash = "sha256-RWqyAdETD/EkDVGcnBPiMcw1mSd78Aayky9yoxSsry4=";
  };
in
{
  home.packages = with pkgs; [
    # poppler # pdf preview
    poppler-utils # pdf preview
  ];

  programs.yazi = {
    enable = true;
    enableZshIntegration = config.programs.zsh.enable;

    flavors = {
      # gruvbox-dark = yaziGruvbox;
      gruvbox-dark = ./gruvbox-dark.yazi;
    };

    initLua = # lua
      ''
        require("full-border"):setup {
        	-- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
        	type = ui.Border.ROUNDED,
        }
      '';

    keymap = {
      mgr.prepend_keymap = [
        # -- core --
        {
          on = "<C-c>";
          run = "quit";
        }
        {
          on = "d";
          run = "remove --permanently";
        }
        {
          on = "q";
          run = "close";
        }
        {
          on = [
            "g"
            "3"
          ];
          run = "cd ~/Downloads/3d-prints";
        }
        {
          on = [
            "g"
            "m"
          ];
          run = "cd /mnt";
        }

        # -- plugins --

        # bypass
        {
          on = "L";
          run = "plugin bypass";
          desc = "Recursively enter child directory, skipping children with only a single subdirectory";
        }
        {
          on = "H";
          run = "plugin bypass reverse";
          desc = "Recursively enter parent directory, skipping parents with only a single subdirectory";
        }
        {
          on = "l";
          run = "plugin bypass smart-enter";
          desc = "Open a file, or recursively enter child directory, skipping children with only a single subdirectory";
        }

        # chmod
        {
          on = [
            "c"
            "m"
          ];
          run = "plugin chmod";
          desc = "Chmod on selected files";
        }

        # diff
        {
          on = "<C-d>";
          run = "plugin diff";
          desc = "Diff the selected with the hovered file";
        }
      ];
    };

    plugins = {
      inherit (pkgs.yaziPlugins)
        bypass
        chmod
        diff
        full-border
        ;
    };

    # REF: https://yazi-rs.github.io/docs/configuration/overview
    settings = {
      manager = {
        layout = [
          1
          4
          3
        ];
        linemode = "none";
        show_hidden = false;
        show_symlink = true;
        sort_by = "alphabetical";
        sort_dir_first = true;
        sort_reverse = false;
        sort_sensitive = true;
      };
    };

    theme.flavor.dark = "gruvbox-dark";
  };
}
