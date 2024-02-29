{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      cmp-buffer
      cmp-emoji
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
