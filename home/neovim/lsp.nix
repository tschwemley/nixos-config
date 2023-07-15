{pkgs, ...}: {
  home.packages = with pkgs; [
    gopls
    nixd
    nodePackages.intelephense
    nodePackages.typescript-language-server
    nodePackages.yaml-language-server
    sqls
  ];

  programs.neovim.plugins = with pkgs.vimPlugins; [
      # lsp shennanery
      lsp-zero-nvim
      #mason-nvim
      #mason-lspconfig-nvim
      nvim-lspconfig
	  {
		  type = "lua";
		  config = ''
			local lsp = require('lsp-zero').preset({})

			lsp.on_attach(function(client, bufnr)
			  lsp.default_keymaps({buffer = bufnr})
			end)

			-- see: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md for naming
			lsp.setup_servers({'gopls', 'intelephense', 'lua_ls', 'nixd', 'sqls', 'tsserver', 'yamlls'})

			-- TODO: see if we need this when using nix or if it comes setup by default
			-- (Optional) Configure lua language server for neovim
			-- require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

			lsp.setup()
		  '';
	  }
  ];
}
