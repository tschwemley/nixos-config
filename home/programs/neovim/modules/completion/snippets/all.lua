local helpers = require("./helpers")
local s = helpers.s
local t = helpers.t
local i = helpers.i
local f = helpers.f or require("luasnip").function_node -- Ensure 'f' is available

-- Snippet Definitions
-- ===================

-- Uses luasnip.util.util.buffer_comment_chars()[1] for the line comment prefix
local function get_line_comment_prefix()
	return require("luasnip.util.util").buffer_comment_chars()[1] or "--"
end

-- Determines the character to use for the box border
local function get_box_border_char()
	local prefix = get_line_comment_prefix()
	-- Try to use the common border chars, fallback to prefix first char
	if prefix:match("^%-%-$") then
		return "-"
	end -- Lua
	if prefix:match("^#$") then
		return "#"
	end -- Python/Shell
	-- Add other common prefixes if needed

	return string.sub(prefix, 1, 1) -- Fallback to the first char of the prefix
end

-- Calculates padding for centering text within a width
local function calculate_padding_for_centering(nodes, total_width)
	local prefix = get_line_comment_prefix()
	local content = nodes[1][1] or "" -- Get text from tabstop i(1)

	-- Available space is total width minus the comment prefix on both sides
	local available_space = total_width - (2 * #prefix)

	local spaces_needed = available_space - #content

	-- Ensure non-negative spaces and at least a little space if possible
	if spaces_needed < 0 then
		spaces_needed = 0
	end

	local left_padding = math.floor(spaces_needed / 2)
	local right_padding = math.ceil(spaces_needed / 2)

	return { left_padding, right_padding }
end

-- Generates the nodes for a box comment
local function create_styled_box(opts)
	local box_width = opts and opts.width or vim.opt.textwidth:get() or 80 -- Use provided width, textwidth, or 80
	local prefix = get_line_comment_prefix()
	local border_char = get_box_border_char()

	-- The top/bottom border line
	local border_line = f(function()
		return prefix .. string.rep(border_char, box_width - #prefix) -- Border fills remaining space
	end, {}) -- No dependencies here, fixed

	-- The middle line with content and padding
	local content_line = f(function(args)
		local padding = calculate_padding_for_centering(args, box_width)
		return prefix .. string.rep(" ", padding[1]) .. args[1][1] .. string.rep(" ", padding[2])
	end, { i(1) }) -- Depends on the text in i(1)

	return {
		border_line,
		t({ "", "" }), -- Space above content
		content_line, -- Content line
		t({ "", "" }), -- Space below content
		border_line, -- Bottom border (reused)
		i(0), -- Final tabstop
	}
end

-- Define the box and bbox snippets using the factory function
local styled_box = s(
	{ trig = "box", namr = "Styled Box Comment (Fixed 60)", dscr = "Creates a box comment with width 60" },
	create_styled_box({ width = 60 })
)
local styled_bbox = s(
	{ trig = "bbox", namr = "Styled Box Comment (Textwidth)", dscr = "Creates a box comment based on textwidth" },
	create_styled_box({})
) -- Uses textwidth default

return {
	styled_box,
	styled_bbox,
}

-- TODO: delete this assuming that the above from gemini works
--
-- local helpers = require("helpers")
-- local f = helpers.f
-- local i = helpers.i
-- local s = helpers.s
-- local t = helpers.t
--
-- -- Snippet Definitions
-- -- ===================
--
-- local function create_box(opts)
--    local pl = opts.padding_length or 4
--
--    local function pick_comment_start_and_end()
--       -- because lua block comment is unlike other language's,
--       --  so handle lua ctype
--       local ctype = 2
--       if vim.opt.ft:get() == "lua" then
--          ctype = 1
--       end
--       local cs = get_cstring(ctype)[1]
--       local ce = get_cstring(ctype)[2]
--       if ce == "" or ce == nil then
--          ce = cs
--       end
--       return cs, ce
--    end
--
--    return {
--       -- top line
--       f(function(args)
--          local cs, ce = pick_comment_start_and_end()
--          return cs .. string.rep(string.sub(cs, #cs, #cs), string.len(args[1][1]) + 2 * pl) .. ce
--       end, { 1 }),
--       t({ "", "" }),
--       f(function()
--          local cs = pick_comment_start_and_end()
--          return cs .. string.rep(" ", pl)
--       end),
--       i(1, "box"),
--       f(function()
--          local cs, ce = pick_comment_start_and_end()
--          return string.rep(" ", pl) .. ce
--       end),
--       t({ "", "" }),
--       -- bottom line
--       f(function(args)
--          local cs, ce = pick_comment_start_and_end()
--          return cs .. string.rep(string.sub(ce, 1, 1), string.len(args[1][1]) + 2 * pl) .. ce
--       end, { 1 }),
--    }
-- end
--
-- local box = s({ trig = "box" }, create_box({ padding_length = 8 }))
-- local bbox = s({ trig = "bbox" }, create_box({ padding_length = 20 }))
--
-- return {
--    box,
--    bbox,
-- }
