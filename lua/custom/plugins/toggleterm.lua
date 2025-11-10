return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup {
        size = 15,
        open_mapping = [[<leader>tt]], -- open/close terminal
        shade_terminals = true,
        direction = 'horizontal', -- can be 'vertical', 'float', or 'tab'
        start_in_insert = true,
        persist_size = true,
        close_on_exit = true,
      }

      -- Optional keymaps for quick splits
      vim.keymap.set('n', '<leader>tv', function()
        require('toggleterm.terminal').Terminal:new({ direction = 'vertical' }):toggle()
      end, { desc = 'Open vertical terminal' })

      vim.keymap.set('n', '<leader>tf', function()
        require('toggleterm.terminal').Terminal:new({ direction = 'float' }):toggle()
      end, { desc = 'Open floating terminal' })
    end,
  },
}
