{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      # pretty things
      gruvbox-material
    ];
    extraLuaConfig = "require 'schwem.colors'";
  };
}
