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

  xdg.configFile."nvim/after/plugin/db.lua".source = ./db.lua;
}
