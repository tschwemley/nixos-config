{ pkgs, ... }:
{
  programs.neovim = with pkgs; {
    extraPackages = [ tree-sitter ];

    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      nvim-treesitter-textobjects
    ];
  };
}
