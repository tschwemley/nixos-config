local ls = require("luasnip")
-- some shorthands...
local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node

local date = function()
	return { os.date("%Y-%m-%d") }
end


--[[ examples in guide: 
      https://sbulav.github.io/vim/neovim-setting-up-luasnip/ 
   ]]
ls.add_snippets(nil, {
	nix = {
		snip({
			trig = 'fetchFromGitHub',
			namr = 'fetchFromGitHub',
			dscr = 'Fetch src from GitHub',
		}, {
         text({'fetchFromGitHub {',
            '  owner = "'}), insert(1, 'owner'), text({'";',
            '  repo = "'}), insert(2, 'repo'), text({'";',
            '  rev = "'}), insert(3, 'revision'), text({'";',
            '  hash = "'}), insert(4, '${lib.fakeHash}'), text({'";',
            '};'}),
         insert(0)
		}),
	},
})
