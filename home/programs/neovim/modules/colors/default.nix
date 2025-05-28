{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    everforest
    # {
    #   type = "lua";
    #   plugin = gruvbox-material-nvim;
    #   config = ''
    #     require('gruvbox-material').setup({
    #       contrast = 'hard'
    #     })
    #   '';
    # }
    gruvbox-nvim
  ];
}
