{
  config,
  pkgs,
  ...
}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    vim-dadbod
    vim-dadbod-completion
    vim-dadbod-ui
  ];

  sops.secrets.vim-dadbod-dsn = {
    sopsFile = ../../secrets.yaml;
  };

  # sops.templates."db.lua" = {
  #   # group = "users";
  #   content = ''
  #     vim.g.db_ui_use_nerd_fonts = 1
  #     ${config.sops.placeholder.vim-dadbod-dsn}
  #   '';
  # };

  xdg.configFile."nvim/after/plugin/db.lua".source = ./db.lua;
}
