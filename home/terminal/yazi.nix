{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    poppler # pdf preview
  ];

  nix.settings = {
    extra-substituters = ["https://yazi.cachix.org"];
    extra-trusted-public-keys = ["yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="];
  };

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
