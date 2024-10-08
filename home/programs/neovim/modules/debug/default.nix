{ pkgs, ... }:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    nvim-dap
    nvim-dap-go
    nvim-dap-ui
  ];

  xdg.configFile."nvim/after/plugin/debug".source = ./lua;
}
