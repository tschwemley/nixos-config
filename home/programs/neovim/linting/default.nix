{pkgs, ...}: {
  programs.neovim = {
    extraPackages = with pkgs; [
      # go
      golangcilint

      # lua
      luacheck

      # nix
      deadnix 

    ];

    plugins = [{
      plugin = pkgs.vimPlugins.nvim-lint;
      type = "lua";
      config = 
        # lua
        ''
          require("lint").linters_by_ft = {
            go = { "golangcilint" },
            lua = { "luacheck" },
            nix = { "deadnix", "nix" },
          }

          vim.api.nvim_create_autocmd({ "BufWritePost" }, {
            callback = function()

              -- try_lint without arguments runs the linters defined in `linters_by_ft`
              -- for the current filetype
              require("lint").try_lint()

              -- You can call `try_lint` with a linter name or a list of names to always
              -- run specific linters, independent of the `linters_by_ft` configuration
              require("lint").try_lint("cspell")
            end,
          })
        '';
    }];
  };
}
