{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    better-escape-nvim
    dressing-nvim
    plenary-nvim
    ollama-nvim
    toggleterm-nvim
    which-key-nvim
  ];
}
