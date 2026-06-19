{ pkgs, ... }:
let
  inherit (pkgs.vscode-extensions.xdebug) php-debug;
in
{
  home.sessionVariables.PHP_DEBUG_PATH = "${php-debug}/share/vscode/extensions/xdebug.php-debug/out/phpDebug.js";

  programs.neovim.extraPackages = with pkgs; [
    numi-cli
    php-debug
  ];

  programs.neovim.plugins = with pkgs.vimPlugins; [
    # bufferline/status line
    bufferline-nvim

    # collections
    # mini-nvim

    # colors
    everforest
    gruvbox-material

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
    nvim-autopairs

    # db
    vim-dadbod
    vim-dadbod-completion
    vim-dadbod-ui

    # debug
    nvim-dap
    nvim-dap-view

    nvim-dap-go

    # diagnostitics
    todo-comments-nvim
    trouble-nvim
    wtf-nvim

    # folds
    nvim-origami

    # fuzzy find
    telescope-nvim
    telescope-frecency-nvim

    # file explorer
    yazi-nvim

    # git
    diffview-nvim
    gitsigns-nvim
    neogit

    # markdown
    obsidian-nvim
    render-markdown-nvim
    vim-table-mode

    # ui/dressing
    colorful-menu-nvim
    noice-nvim

    # utility
    nvumi

    # other/unsorted
    lazydev-nvim
    FTerm-nvim
    nui-nvim
    nvim-colorizer-lua
    nvim-web-devicons
    smart-splits-nvim
    snacks-nvim
    vim-abolish
  ];
}
