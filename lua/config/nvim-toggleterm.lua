

require'toggleterm'.setup {
    float_opts = {
        border = 'double',
        winblend = 10, -- display not expected, commit issue: https://github.com/akinsho/toggleterm.nvim/issues/617
        title_pos = 'center',
  },
}

-- 终端
vim.api.nvim_set_keymap('n', '<C-t>', '<cmd>ToggleTerm direction=float<CR>', { noremap = true, silent = true })

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
