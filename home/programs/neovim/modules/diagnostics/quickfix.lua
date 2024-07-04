-- When using `dd` in the quickfix list, remove the item from the quickfix list.
local function remove_qf_item()
  local curqfidx = vim.fn.line('.') - 1
  local qfall = vim.fn.getqflist()
  table.remove(qfall, curqfidx + 1)
  vim.fn.setqflist(qfall, 'r')
  vim.cmd(curqfidx + 1 .. 'cfirst')
  vim.cmd('copen')
end

-- Create a user command
vim.api.nvim_create_user_command('RemoveQFItem', remove_qf_item, {})

-- Use autocmd to map dd only in quickfix windows
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'qf',
  callback = function()
    vim.api.nvim_buf_set_keymap(0, 'n', 'dd', ':RemoveQFItem<CR>', { noremap = true, silent = true })
  end
})
