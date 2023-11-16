{
  pkgs,
  ...
}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      # comment-nvim
      nvim-treesitter.withAllGrammars
    ];
	extraLuaConfig = "";
  };
}
