{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    gitsigns-nvim
    mini-git
  ];
  # vim-fugitive # TODO: this ist
  xdg.configFile."nvim/after/plugin/git.lua".text = /* lua */ ''
    require("gitsigns").setup()
    -- vim.keymap.set('n', '<leader>g', ':G<cr>', { noremap = true })
    '';
}
