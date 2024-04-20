local function prettifyJSON()
   vim.cmd("%!jq .");
end

local function minifyJSON()
   vim.cmd("%!jq -r tostring");
end

local function toggleFormat()
   if vim.api.nvim_buf_line_count(0) == 1 then
      prettifyJSON()
   else
      minifyJSON()
   end
end

vim.keymap.set('n', '<leader>lf', toggleFormat, { buffer = true })
