{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      # bars and lines; you know - the fun stuff
      bufferline-nvim
      lualine-nvim

      nnn-vim
      telescope-nvim
    ];
    extraLuaConfig = "require 'schwem.navigation'";
  };
}
