{lib, ...}: {
  imports = [
    ./modules
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = lib.mkDefault true;
    # extraLuaPackages = ps: with ps; [lua-utils-nvim];
    vimAlias = true;
    vimdiffAlias = true;
    withPython3 = false;
    withNodeJs = false;
  };

  # link neovim config to $HOME/.config/nvim
  # xdg.configFile = {
  #   "nvim".source = ./config;
  # };
}
