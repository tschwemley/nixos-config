{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      nnn-vim
      nvim-ufo
      telescope-nvim
    ];
  };
}
