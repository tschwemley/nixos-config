require("schwem.helpers").set_tabs(3)

require("lazydev").setup({
	library = {
		-- { words = { "nixCats" }, path = (require("nixCats").nixCatsPath or "") .. "/lua" },
		{ path = "luvit-meta/library", words = { "vim%.uv" } },
	},
})
