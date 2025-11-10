-- ~/.config/nvim/lua/custom/terminal.lua
-- Simple native terminal toggles (no plugins)

local M = {}

-- Keep references to the terminal buffers/windows
local term_buf = nil
local term_win = nil

-- Helper: open or toggle a terminal
local function toggle_term(split_cmd)
  if term_win and vim.api.nvim_win_is_valid(term_win) then
    -- Close the terminal window
    vim.api.nvim_win_close(term_win, true)
    term_win = nil
    return
  end

  -- Open the split and start terminal
  vim.cmd(split_cmd)
  vim.cmd 'terminal'
  vim.cmd 'startinsert'

  term_win = vim.api.nvim_get_current_win()
  term_buf = vim.api.nvim_get_current_buf()
end

-- Kill terminal buffer (if exists)
function M.close_term()
  if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
    vim.api.nvim_buf_delete(term_buf, { force = true })
    term_buf = nil
    term_win = nil
  end
end

-- Keymaps
vim.keymap.set('n', '<leader>tth', function()
  toggle_term 'belowright split'
end, { desc = 'Toggle horizontal terminal' })

vim.keymap.set('n', '<leader>ttv', function()
  toggle_term 'vsplit'
end, { desc = 'Toggle vertical terminal' })

vim.keymap.set('n', '<leader>ttt', function()
  M.close_term()
end, { desc = 'Toggle terminal' })

-- You still need this to label the prefix:
local wk = require 'which-key'

wk.register({
  t = { -- first t
    name = '[T]oggle',
    t = { name = '[T]oggle [T]erminal' }, -- second t
  },
}, { prefix = '<leader>' })

-- Quality of life terminal navigation
vim.keymap.set('t', '<Esc><Esc>', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })
vim.keymap.set('t', '<C-h>', [[<C-\><C-n><C-w>h]], { desc = 'Move left' })
vim.keymap.set('t', '<C-j>', [[<C-\><C-n><C-w>j]], { desc = 'Move down' })
vim.keymap.set('t', '<C-k>', [[<C-\><C-n><C-w>k]], { desc = 'Move up' })
vim.keymap.set('t', '<C-l>', [[<C-\><C-n><C-w>l]], { desc = 'Move right' })

return M
