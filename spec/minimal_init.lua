local temp_dir = vim.fn.stdpath('data') .. '/lazy-test'
local plenary_dir = temp_dir .. '/plenary.nvim'

if vim.fn.isdirectory(plenary_dir) == 0 then
  vim.fn.system({
    'git', 'clone',
    'https://github.com/nvim-lua/plenary.nvim.git',
    plenary_dir
  })
end

vim.opt.rtp:prepend(plenary_dir)
vim.opt.rtp:prepend('.')
vim.opt.rtp:prepend('..')
vim.cmd('runtime plugin/plenary.vim')
vim.opt.swapfile = false
vim.opt.undofile = false
