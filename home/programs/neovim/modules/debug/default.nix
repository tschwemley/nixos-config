{pkgs, ...}: {
  imports = [./php.nix];

  programs.neovim.extraPackages = [pkgs.vscode-extensions.xdebug.php-debug];

  programs.neovim.plugins = with pkgs.vimPlugins; [
    nvim-dap
    nvim-dap-go
    nvim-dap-ui
    telescope-dap-nvim
  ];

  # TODO: uncomment, move out of after/, and load only when starting a debugging session
  xdg.configFile."nvim/after/plugin/debug/debug.lua".source = ./lua/debug.lua;
}
