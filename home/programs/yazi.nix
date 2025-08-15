{
  config,
  pkgs,
  ...
}:
let
  yaziGruvbox = pkgs.fetchFromGitHub {
    owner = "bennyyip";
    repo = "gruvbox-dark.yazi";
    rev = "91fdfa7";
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
      gruvbox-dark = yaziGruvbox;
    };

    keymap = {
      mgr.prepend_keymap = [
        {
          on = "q";
          run = "close";
        }
        {
          on = "<C-c>";
          run = "quit";
        }
      ];
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
