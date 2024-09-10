
-- 全局替换 <C-r>
require('spectre').setup({
})

-- 全局替换
vim.api.nvim_set_keymap('n', '<C-r>', '<cmd>Spectre<CR>', { noremap = true, silent = true })

