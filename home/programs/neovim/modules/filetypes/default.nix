{pkgs, ...}: {
  # imports = [./go.nix];

  programs.neovim.plugins = with pkgs.vimPlugins; [
    glow-nvim
  ];

  xdg.configFile = {
    "nvim/after/plugin/filetypes.lua".source = ./filetypes.lua;
    "nvim/after/ftplugin".source = ./ftplugin;

    "nvim/syntax/tid.vim".source = ./syntax/tid.vim;
  };
}
