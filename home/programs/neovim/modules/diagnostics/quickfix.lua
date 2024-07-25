-- When using `dd` in the quickfix list, remove the item from the quickfix list.
local function remove_qf_item()
  local curqfidx = vim.fn.line('.') - 1
  local qfall = vim.fn.getqflist()
  table.remove(qfall, curqfidx + 1)
  vim.fn.setqflist(qfall, 'r')
  vim.cmd(curqfidx + 1 .. 'cfirst')
  vim.cmd('copen')
end

-- Use autocmd to map dd only in quickfix windows
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'qf',
  callback = function()
    vim.keymap.set('n', 'dd', remove_qf_item, { buffer = true })
    vim.keymap.set('v', 'd', remove_qf_item, { buffer = true })
  end
})
