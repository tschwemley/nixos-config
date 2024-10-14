{
  pkgs,
  ...
}:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    nvim-dbee
    vim-dadbod
    vim-dadbod-completion
    vim-dadbod-ui
  ];

  xdg.configFile."nvim/after/plugin/db.lua".source = ./db.lua;
}
