{
  config,
  pkgs,
  ...
}:
{
  # dependencies required by plugins
  home.packages = with pkgs; [
    dragon-drop
    f3d
    poppler-utils # pdf preview
  ];

  programs.yazi = {
    enable = true;
    enableZshIntegration = config.programs.zsh.enable;

    initLua = /* lua */ ''
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
          on = "<C-n>";
          run = "shell -- dragon -x -i -T '$0'";
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
        {
          on = [
            "g"
            "/"
          ];
          run = "cd /";
        }

        # -- plugins --

        # # bypass
        # {
        #   on = "L";
        #   run = "plugin bypass";
        #   desc = "Recursively enter child directory, skipping children with only a single subdirectory";
        # }
        # {
        #   on = "H";
        #   run = "plugin bypass reverse";
        #   desc = "Recursively enter parent directory, skipping parents with only a single subdirectory";
        # }
        # {
        #   on = "l";
        #   run = "plugin bypass smart-enter";
        #   desc = "Open a file, or recursively enter child directory, skipping children with only a single subdirectory";
        # }

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
        # bypass
        chmod
        diff
        f3d-preview
        full-border
        glow
        ;
    };

    # REF: https://yazi-rs.github.io/docs/configuration/overview
    settings = {
      mgr = {
        linemode = "mtime";
        show_hidden = true;
        show_symlink = true;
        sort_by = "alphabetical";
        sort_dir_first = true;
        sort_reverse = false;
        sort_sensitive = true;

        layout = [
          1
          4
          3
        ];
      };

      plugin = {
        prepend_preloaders = [
          # 3d objects
          {
            name = "*.3mf";
            run = "f3d-preview";
          }
          {
            name = "*.obj";
            run = "f3d-preview";
          }
          {
            name = "*.pts";
            run = "f3d-preview";
          }
          {
            name = "*.ply";
            run = "f3d-preview";
          }
          {
            name = "*.stl";
            run = "f3d-preview";
          }
          {
            name = "*.step";
            run = "f3d-preview";
          }
          {
            name = "*.stp";
            run = "f3d-preview";
          }
        ];

        prepend_previewers = [
          # 3d objects
          {
            name = "*.3mf";
            run = "f3d-preview";
          }
          {
            name = "*.obj";
            run = "f3d-preview";
          }
          {
            name = "*.pts";
            run = "f3d-preview";
          }
          {
            name = "*.ply";
            run = "f3d-preview";
          }
          {
            name = "*.stl";
            run = "f3d-preview";
          }
          {
            name = "*.step";
            run = "f3d-preview";
          }
          {
            name = "*.stp";
            run = "f3d-preview";
          }
        ];
      };
    };
  };
}
