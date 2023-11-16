{ pkgs, lib, ... }:
{
	programs.neovim = {
		enable = true;
		defaultEditor = true;
		extraLuaConfig = ''
			require "modules.colorschemes"	
			-- require "modules.keymap"	
			require "modules.lsp"	
			require "modules.options"	
		'';
		extraLuaPackages = [];
		plugins = with pkgs.vimPlugins; [
			gruvbox-material
			lsp-zero-nvim
			luasnip
			lualine-nvim
			nnn-vim
			nvim-dap
			nvim-luadev
			nvim-lspconfig
			telescope-nvim
			toggleterm-nvim
			trouble-nvim
			nvim-treesitter
			vim-dadbod
			vim-dadbod-ui
			vim-dadbod-completion
			which-key-nvim

			# completion plugins
			nvim-cmp
			cmp_luasnip
			cmp-nvim-lsp
			cmp-nvim-lua

		];
		withNodeJs = true;
		withPython3 = true;
		vimAlias = true;
		vimdiffAlias = true;
	};

      xdg.configFile = {
        "nvim/lua".source = ./lua;
      	#"nvim/init.lua".source = ./lua/init.lua;
        #"nvim/parser".source = "${parserDir}";
      };
}
