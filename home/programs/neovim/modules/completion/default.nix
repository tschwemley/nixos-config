{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    codecompanion
    neodev-nvim
    nvim-cmp
    cmp-buffer
    cmp-cmdline
    cmp-dap
    cmp-nvim-lsp
    cmp-path
    cmp_luasnip
  ];

  xdg.configFile = {
    "nvim/after/plugin/ai.lua".source = ./ai.lua;
    "nvim/after/plugin/completion.lua".source = ./completion.lua;
  };
}
