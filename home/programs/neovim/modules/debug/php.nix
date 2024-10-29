{pkgs, ...}: {
  programs.neovim.extraPackages = [pkgs.vscode-extensions.xdebug.php-debug];

  xdg.configFile."nvim/after/plugin/debug/php.lua" = {
    target = "nvim/after/plugin/debug/php.lua";
    text =
      /*
      lua
      */
      ''
        local dap = require('dap')

        dap.adapters.php = {
          type = 'executable',
          command = '${pkgs.nodejs_22}/bin/node}',
          args = { '${pkgs.vscode-extensions.xdebug.php-debug}/share/vscode/extensions/xdebug.php-debug/out/phpDebug.js' }
        }
      '';
  };
}
