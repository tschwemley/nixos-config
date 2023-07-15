{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      vim-dadbod
      vim-dadbod-ui
      vim-dadbod-completion
    ];
  };
}
