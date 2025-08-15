{pkgs, ...}: {
	programs.neovim.plugins = with pkgs.vimPlugins; [
		telescope-nvim

		telescope-cheat-nvim
		telescope-frecency-nvim
	];

	# xdg.configFile."nvim/after/plugin/telescope.lua".source = ./lua/telescope.lua;

	xdg.configFile."nvim/after/plugin/telescope.lua".text = # lua
		''
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")

			telescope.load_extension("frecency")

			-- [f]ind
			vim.keymap.set("n", "<leader>f", builtin.find_files)

			-- [s]earch commands
			vim.keymap.set("n", "<leader>sc", builtin.commands)
			vim.keymap.set("n", "<leader>sf", builtin.find_files)
			vim.keymap.set("n", "<leader>sh", builtin.help_tags)
			vim.keymap.set("n", "<leader>sk", builtin.keymaps)
			vim.keymap.set("n", "<leader>st", builtin.live_grep)
			vim.keymap.set("n", "<leader>sw", builtin.grep_string)

			-- misc. commands
			vim.keymap.set("n", "<leader>bl", builtin.buffers)
		'';
}
