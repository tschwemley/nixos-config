--
-- This file contains mini modules with minimal to no deviation from the default setup config
--
-- Plugins I've tried and not liked:
--    MAYBE: mini.diff => makes rnu number a different color based on changes? fkn hate that
--    * mini.git coloring all fucked; git wrapper seems useless [e.g. :Git blame works in fugitive
--       w/ sane defaults. mini.git requires args to be passed. Then why don't I just use !git ...])

-- Appearance
require("mini.icons").setup()
require("mini.statusline").setup()

-- General WorkFlow
-- require("mini.diff").setup({
-- 	view = {
-- 		style = "sign",
-- 	},
-- })
require("mini.visits").setup()

-- Text Editing
require("mini.align").setup()
require("mini.move").setup()
