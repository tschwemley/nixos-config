{ pkgs, ... }:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    # bufferline/status line
    bufferline-nvim

    # collections
    mini-nvim

    # git
    neogit

    # fuzzy find
    telescope-nvim

    # file explorer
    yazi-nvim

    # colors
    everforest
    gruvbox-nvim

    # completion
    blink-compat # necessary for compat with any nvim-cmp plugins
    blink-cmp
    blink-cmp-env
    blink-emoji-nvim
    cmp-dap
    css-vars-nvim
    luasnip

    # DB
    vim-dadbod
    vim-dadbod-completion
    vim-dadbod-ui

    # other/unsorted
    todo-comments-nvim
  ];
}
