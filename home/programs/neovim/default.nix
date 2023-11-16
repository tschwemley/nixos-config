{lib, ...}: {
  imports = [
    ./modules
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = lib.mkDefault true;
    withPython3 = true;
    withNodeJs = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  # link neovim config to $HOME/.config/nvim
  xdg.configFile = {
    "nvim".source = ./config;
  };
}
