local function new_term(split_cmd)
  vim.cmd(split_cmd)
  vim.cmd 'terminal'
  vim.cmd 'startinsert'
end

local function close_current_term()
  local bufnr = vim.api.nvim_get_current_buf()
  local ok, term_type = pcall(vim.api.nvim_buf_get_option, bufnr, 'buftype')
  if ok and term_type == 'terminal' then
    vim.api.nvim_buf_delete(bufnr, { force = true })
  end
end

-- Keymaps
vim.keymap.set('n', '<leader>ttb', function()
  new_term 'belowright split'
end, { desc = 'Toggle Terminal to the Bottom' })

vim.keymap.set('n', '<leader>ttr', function()
  new_term 'vsplit'
end, { desc = 'Toggle Terminal to the Right' })

vim.keymap.set('n', '<leader>ttt', close_current_term, { desc = 'Close terminal' })

-- Terminal navigation
vim.keymap.set('t', '<Esc><Esc>', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })
vim.keymap.set('t', '<C-h>', [[<C-\><C-n><C-w>h]], { desc = 'Move left' })
vim.keymap.set('t', '<C-j>', [[<C-\><C-n><C-w>j]], { desc = 'Move down' })
vim.keymap.set('t', '<C-k>', [[<C-\><C-n><C-w>k]], { desc = 'Move up' })
vim.keymap.set('t', '<C-l>', [[<C-\><C-n><C-w>l]], { desc = 'Move right' })

return {}
