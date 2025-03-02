{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    # database
    nvim-dbee
    vim-dadbod
    vim-dadbod-completion
    vim-dadbod-ui

    #git 
    gitsigns-nvim
    neogit
  ];

  xdg.configFile = {
    "nvim/after/plugin/db.lua".source = ./db.lua;
    "nvim/after/plugin/git.lua".source = ./git.lua;
  };
}
