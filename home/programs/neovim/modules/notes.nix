{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      neorg
      neorg-telescope
    ];
  };
}
