{pkgs, ...}: {
  home.packages = with pkgs; [
    delve
    php81Extensions.xdebug
  ];

  programs.neovim.plugins = with pkgs.vimPlugins; [
    nvim-dap
    # nvim-dap-ui
  ];
}
