{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    gitsigns-nvim
    mini-git
  ];

  xdg.configFile."nvim/after/plugin/git.lua".text = /* lua */ ''
    require("gitsigns").setup()
    require('mini.git').setup()

    -- vim.keymap.set('n', '<leader>g', ':G<cr>', { noremap = true })
    '';
}
