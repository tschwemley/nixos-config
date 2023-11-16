{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      yuck-vim
    ];
  };
}
