{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      copilot-vim
      # copilot-cmp
      # copilot-lua
      cmp-buffer
      cmp_luasnip
      cmp-nvim-lsp
      cmp-nvim-lua
      cmp-path
      friendly-snippets
      luasnip
      nvim-cmp
    ];
  };
}
