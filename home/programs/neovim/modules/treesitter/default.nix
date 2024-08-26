{pkgs, ...}: {
  # programs.neovim.plugins = with pkgs.vimPlugins; [
  programs.neovim.plugins = [
    # (import ./treesitter.nix pkgs)
    pkgs.vimPlugins.nvim-treesitter.withAllGrammars
  ];

  # programs.neovim.extraPackages = [
  #   # (import ./treesitter.nix pkgs)
  #   pkgs.vimPlugins.nvim-treesitter.withAllGrammars
  # ];

  xdg.configFile."nvim/after/plugin/treesitter.lua".source = ./treesitter.lua;
}
