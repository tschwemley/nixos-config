require("schwem.helpers").set_tabs(2)

vim.opt_local.wrap = true

-- on save automatically export to markdown
-- vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
--    pattern = { '*.norg' },
--    -- command = ':Neorg export to-file export.md'
--    callback = function(event)
--       print(string.format('event fired: %s', vim.inspect(event)))
--    end
-- })
