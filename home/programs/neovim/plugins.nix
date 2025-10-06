{ pkgs, ... }:
let
  inherit (pkgs.vscode-extensions.xdebug) php-debug;
in
{
  home.sessionVariables.PHP_DEBUG_PATH = "${php-debug}/share/vscode/extensions/xdebug.php-debug/out/phpDebug.js";

  programs.neovim.extraPackages = [ php-debug ];

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
    blink-nerdfont-nvim
    blink-cmp-conventional-commits
    cmp-dap
    css-vars-nvim
    luasnip

    # db
    vim-dadbod
    vim-dadbod-completion
    vim-dadbod-ui

    # debug
    nvim-dap

    # diagnostitics
    todo-comments-nvim
    trouble-nvim
    wtf-nvim

    # folds
    nvim-origami

    # fuzzy find
    # fzf-lua # BUG: failing tests
    telescope-nvim
    telescope-frecency-nvim

    # file explorer
    yazi-nvim

    # git
    gitsigns-nvim
    neogit

    # ui
    noice-nvim

    # other/unsorted
    lazydev-nvim
    # nui-nvim TODO: delete me if not necessary/included via noice
    nvim-colorizer-lua
    taskwarrior3
  ];
}
