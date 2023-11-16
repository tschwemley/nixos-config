local Colorschemes = {
	--change_colorscheme = function(new)
		--colorschemes[new]()
	--end

	gruvbox_material = function()
		vim.o.termguicolors = true
		vim.o.background = "dark"

		vim.g.gruvbox_material_background = "medium"
		--vim.g.gruvbox_material_better_performance = 1

		vim.cmd("colorscheme gruvbox-material")

		-- TODO: uncomment this when I figure out which lines plugins I want to use
		--vim.g.lightline = { colorscheme = "gruvbox_material" }
	end
}

-- load gruvbox-material by default
Colorschemes.gruvbox_material()
return Colorschemes
