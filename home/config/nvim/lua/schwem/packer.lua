local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
	if not PackerInstalled(install_path) then
		fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path }
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()
return require("packer").startup(function(use)
	-- Aesthetics
	use "sainnhe/everforest"
	use "sainnhe/gruvbox-material"
	use "rebelot/kanagawa.nvim"
	use "glepnir/dashboard-nvim"
	use "shortcuts/no-neck-pain.nvim"
	use "sainnhe/sonokai"

	-- Colors
	use "uga-rosa/ccc.nvim"

	-- Code Navigation
	use "ray-x/lsp_signature.nvim"

	-- Completion
	use "hrsh7th/nvim-cmp"
	use "hrsh7th/cmp-buffer"
	use "hrsh7th/cmp-cmdline"
	use "hrsh7th/cmp-nvim-lsp"
	use "hrsh7th/cmp-path"
	use "rcarriga/cmp-dap"

	-- Databases & Big Data
	use "tpope/vim-dadbod"
	use "kristijanhusak/vim-dadbod-ui"

	-- Debugging
	use "mfussenegger/nvim-dap"
	use "rcarriga/nvim-dap-ui"
	use "theHamsta/nvim-dap-virtual-text"
	use "leoluz/nvim-dap-go"
	use "jayp0521/mason-nvim-dap.nvim"
	use {
		"rest-nvim/rest.nvim",
		requires = "nvim-lua/plenary.nvim",
	}

	-- Dependency & Package Management
	use "wbthomason/packer.nvim"
	use "williamboman/mason.nvim"

	-- Diagnostics
	use {
		"folke/trouble.nvim",
		requires = "nvim-tree/nvim-web-devicons",
	}

	-- Editing
	use { "kylechui/nvim-surround", tag = "*" }


	-- Formatting
	use "numtostr/comment.nvim"
	use "lukas-reineke/indent-blankline.nvim"

	-- Lua
	use {
		"abecodes/tabout.nvim",
		after = { "nvim-cmp" }, -- load after plugins that use tab
		requires = { "nvim-treesitter" },
	}

	-- Git
	use {
		"pwntester/octo.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-tree/nvim-web-devicons",
		},
	}
	-- Lua

	-- LSP
	use "folke/todo-comments.nvim"
	use "neovim/nvim-lspconfig"
	use "williamboman/mason-lspconfig.nvim"
	use {
		"jose-elias-alvarez/null-ls.nvim",
		requires = { "nvim-lua/plenary.nvim" },
	}
	use "jayp0521/mason-null-ls.nvim"
	use "simrat39/symbols-outline.nvim"
	use "glepnir/lspsaga.nvim"

	-- Navigation and buffer/statusline
	use {
		"akinsho/bufferline.nvim",
		tag = "v2.*",
		requires = "nvim-tree/nvim-web-devicons",
	}
	use "ggandor/leap.nvim"
	use {
		"nvim-tree/nvim-tree.lua",
		requires = { "nvim-tree/nvim-web-devicons" },
	}
	use {
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	}
	use "luukvbaal/nnn.nvim"

	-- Notes
	use {
		"nvim-neorg/neorg",
		after = { "nvim-treesitter", "telescope.nvim" },
		requires = "nvim-neorg/neorg-telescope", -- Be sure to pull in the repo
		run = ":Neorg sync-parsers",
	}
	-- use {
	--     "max397574/neorg-kanban",
	--     after = { "neorg" },
	-- }
	use {
		"wthollingsworth/pomodoro.nvim",
		requires = "MunifTanjim/nui.nvim",
		config = function()
			require("pomodoro").setup {
				time_work = 30,
				time_break_short = 5,
				time_break_long = 30,
				timers_to_long_break = 4,
			}
		end,
	}
	use {
		"sudormrfbin/cheatsheet.nvim",

		requires = {
			{ "nvim-telescope/telescope.nvim" },
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
		},
	}

	-- Snippets
	use { "L3MON4D3/LuaSnip", tag = "v1.*" }

	-- Telescope
	use {
		"nvim-telescope/telescope.nvim",
		tag = "0.1.*",
		requires = {
			"nvim-lua/plenary.nvim",
			"MrcJkb/telescope-manix",
		},
	}

	-- Terminal
	use { "akinsho/toggleterm.nvim", tag = "*" }

	-- Treesitter
	use {
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update { with_sync = true }
		end,
	}
	use "nvim-treesitter/nvim-treesitter-context"
	use "p00f/nvim-ts-rainbow"
	use "JoosepAlviste/nvim-ts-context-commentstring"

	-- Util
	use "folke/which-key.nvim"
	use { "jdhao/better-escape.vim", event = "InsertEnter" }

	-- TODO: organize
	use "ledger/vim-ledger"

	-- Folding
	use {
		"kevinhwang91/nvim-ufo",
		requires = "kevinhwang91/promise-async",
	}
	use "lewis6991/impatient.nvim"
	use "nvim-lua/plenary.nvim"

	if packer_bootstrap then
		require("packer").sync()
	end
end)
