local function prettifyJSON()
   vim.cmd("%!jq .");
end

local function minifyJSON()
   vim.cmd("%!jq -r tostring");
end

-- vim.keymap.set('n', '<leader>lfp', prettifyJSON)
-- vim.keymap.set('n', '<leader>lfm', minifyJSON)

