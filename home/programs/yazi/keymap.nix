{
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
        "l"
      ];
      run = "cd ~/.local";
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
}
