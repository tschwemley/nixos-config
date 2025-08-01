{
self,
pkgs,
...
}: let
  otter = import ./otter.nix pkgs.vimPlugins;

  packages = {
    lsp = with pkgs; [
      lua-language-server
      # nil
      nodePackages.bash-language-server
      nodePackages.intelephense
      nodePackages.typescript-language-server
      # phpactor
      python313Packages.python-lsp-server
      typescript
      yaml-language-server

      # htmx-lsp
      # marksman
      nixd
    ];

    # utils = with pkgs; [
    #   json2go
    #   sqlfluff
    #   taplo
    # ];
  };

  plugins = with pkgs.vimPlugins; {
    lsp = [
      otter
      nvim-lspconfig
    ];
  };

  inherit (self) lib;
in {
  imports = [./go.nix];

  programs.neovim = {
    extraPackages = lib.flattenAttrs packages;
    plugins = lib.flattenAttrs plugins;
  };


  # TODO: split this into separate file after tinkering
  xdg.configFile = {
    # global lsp config in nvim/plugin
    "nvim/plugin/lsp.lua".text =
      #lua
      ''
        vim.lsp.config('*', {
          on_attach = function(client, bufnr)
            -- Override omnifunc/tagfunc from other plugins
            vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', {buf = bufnr})
            vim.api.nvim_set_option_value('tagfunc', 'v:lua.vim.lsp.tagfunc', {buf = bufnr})

            local opts = { buffer = bufnr, silent = true }

            -- Navigation (keep vim.lsp.buf for single-target actions)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

            -- Navigation (use Telescope for multi-target/browsable results)
            vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', opts)
            vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<cr>', opts)
            vim.keymap.set('n', 'gt', '<cmd>Telescope lsp_type_definitions<cr>', opts)

            -- Information & Help (keep vim.lsp.buf for popups)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
            vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)

            -- Code Actions & Refactoring (keep vim.lsp.buf for direct actions)
            vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
            vim.keymap.set({'n', 'v'}, '<leader>f', vim.lsp.buf.format, opts)

            -- Diagnostics (mixed: Telescope for browsing, vim.diagnostic for navigation)
            -- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
            vim.keymap.set('n', '<leader>d', '<cmd>Telescope diagnostics bufnr=0<cr>', opts)
            vim.keymap.set('n', '<leader>D', '<cmd>Telescope diagnostics<cr>', opts)

            -- Symbols (Telescope excels here)
            vim.keymap.set('n', '<leader>ds', '<cmd>Telescope lsp_document_symbols<cr>', opts)
            vim.keymap.set('n', '<leader>ws', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', opts)

            -- Workspace Management (keep vim.lsp.buf - these are direct actions)
            vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
            vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
            vim.keymap.set('n', '<leader>wl', function()
              print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, opts)
          end
        })

        -- Global diagnostic configuration
        vim.diagnostic.config({
          signs = true,
          underline = true,
          virtual_text = true,
          severity_sort = true,
          update_in_insert = false,
        })
        })
      '';

    # static server configs in nvim/lsp
    "nvim/lsp/intelephense.lua".source = ./lspconfigs/intelephense.lua;

    # "nvim/lua/lspconfigs".source = ./lspconfigs;

    # "nvim/after/lsp/lua_ls.lua".source = ./lspconfigs/lua_ls.lua;
    #
    # "nvim/after/plugin/lsp/keymaps.lua".source = ./keymaps.lua;
    # "nvim/after/lsp/init.lua".source = ./lsp.lua;
    # "nvim/after/plugin/lsp/none_ls.lua".source = ./none_ls.lua;

    # TODO: Testing below config

    # "nvim/after/lsp/init.lua".text =

    # "nvim/after/lsp/intelephense.lua".source = ./lspconfigs/intelephense.lua;
    # "nvim/lsp/intelephense.lua".source = ./lspconfigs/intelephense.lua;
  };
}
