{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./modules
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = lib.mkDefault true;
    extraLuaConfig =
      /*
      lua
      */
      ''
        require('schwem.keymap')
        require('schwem.set')

        vim.api.nvim_create_user_command("Dump", function(opts)
          print(opts.args)
          print(opts.args[0])
          local ok, result = pcall(require, opts.args[0])
          if ok then
            if opts.args[1] ~= nil then
              result = result[ opts.args[1] ]
            end

            print(vim.inspect(result))
          else
            print("Error loading module: " .. opts.args)
          end
        end, { nargs = "+" })
      '';

    # node is sometimes used as a plugin dependency. E.g. for some debuggers/lsp tools
    extraPackages = [pkgs.nodejs];

    vimAlias = true;
    vimdiffAlias = true;
    withPython3 = false;
    withNodeJs = false;
  };
}
