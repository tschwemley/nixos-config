{ pkgs, ... }:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    # bufferline/status line
    bufferline-nvim

    # collections
    mini-nvim

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

    # db
    vim-dadbod
    vim-dadbod-completion
    vim-dadbod-ui

    # diagnostitics
    todo-comments-nvim
    trouble-nvim
    wtf-nvim

    # fuzzy find
    telescope-nvim

    # file explorer
    yazi-nvim

    # git
    neogit

    # other/unsorted
    lazydev-nvim
    nvim-colorizer-lua
    taskwarrior3
  ];
}
