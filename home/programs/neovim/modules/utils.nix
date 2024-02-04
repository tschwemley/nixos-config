{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    better-escape-nvim
    dressing-nvim
    nvim-web-devicons
    ollama-nvim
    plenary-nvim
    toggleterm-nvim
    which-key-nvim
    # TODO: I think there may be a better spot for these two:
    todo-comments-nvim
    trouble-nvim
  ];
}
