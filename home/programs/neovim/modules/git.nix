{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [neogit];
}
