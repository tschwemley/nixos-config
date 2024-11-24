{pkgs, ...}: {
  imports = [./php.nix];

  programs.neovim.extraPackages = [pkgs.vscode-extensions.xdebug.php-debug];

  programs.neovim.plugins = with pkgs.vimPlugins; [
    nvim-dap
    nvim-dap-go
    nvim-dap-ui
    telescope-dap-nvim
  ];

  # xdg.configFile."nvim/after/plugin/debug".source = ./lua;
  xdg.configFile."nvim/after/plugin/debug/debug.lua".source = ./lua/debug.lua;
}
