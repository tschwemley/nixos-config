{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    bufferline-nvim
    edgy-nvim
    lualine-nvim
    noice-nvim

    # TODO: should use nvim-notify?
    # nvim-notify
  ];

  xdg.configFile = {
    "nvim/after/plugin/edgy.lua".source = ./edgy.lua;
    "nvim/after/plugin/lines.lua".source = ./lines.lua;
    "nvim/after/plugin/noice.lua".source = ./noice.lua;
  };
}
# REF:
#   - https://github.com/folke/edgy.nvim
