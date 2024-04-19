{pkgs, ...}: {
  programs.neovim.extraPackages = with pkgs; [
    delve
  ];

  programs.neovim.plugins = with pkgs.vimPlugins; [
    nvim-dap
    nvim-dap-go
  ];

  xdg.configFile."nvim/after/plugin/debug".source = ./lua;
}
