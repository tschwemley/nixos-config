{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    # db plugins
    vim-dadbod
    vim-dadbod-completion
    vim-dadbod-ui

    #git plugins
    gitsigns-nvim
    neogit

    # other
    taskwarrior3
  ];

  xdg.configFile = {
    "nvim/after/plugin/db.lua".source = ./db.lua;
    "nvim/after/plugin/git.lua".source = ./git.lua;
  };
}
