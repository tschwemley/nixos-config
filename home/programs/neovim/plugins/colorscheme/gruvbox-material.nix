pkgs: {
  plugin = pkgs.vimPlugins.gruvbox-material;
  type = "lua";
  config =
    /*
    lua
    */
    ''
      vim.o.termguicolors = true
      vim.o.background = "dark"

      vim.g.gruvbox_material_background = "medium"
      --vim.g.gruvbox_material_better_performance = 1

      vim.cmd("colorscheme gruvbox-material")
    '';
}
