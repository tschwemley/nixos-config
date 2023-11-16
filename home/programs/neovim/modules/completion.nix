{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      nvim-cmp
      cmp-buffer
      cmp_luasnip
      cmp-nvim-lsp
      cmp-nvim-lua
      cmp-path
      luasnip
    ];
  };
}
