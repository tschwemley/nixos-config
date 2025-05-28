{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # poppler # pdf preview
    poppler-utils # pdf preview
  ];

  programs.yazi = {
    enable = true;

    enableZshIntegration = config.programs.zsh.enable;
    settings = {
      # configuration docs: https://yazi-rs.github.io/docs/configuration/overview
      manager = {
        layout = [1 4 3];
        sort_by = "alphabetical";
        sort_sensitive = true;
        sort_reverse = false;
        sort_dir_first = true;
        linemode = "none";
        show_hidden = false;
        show_symlink = true;
      };
    };
  };
}
