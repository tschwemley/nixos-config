{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      comment-nvim
      glow-nvim
      nvim-surround
    ];
  };
}
