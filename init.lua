require("global")
require("packerManager")
require("keymaps")

vim.cmd('colorscheme tokyonight-moon')

vim.api.nvim_create_autocmd("FileType", {
  -- pattern = {"*.c", "*.h", "*.cpp", "*.hpp", "*.tpp", "*.cc", "*.hh"},
  pattern = {'c', 'h', 'cpp', 'hpp', 'tpp', 'cc', 'hh'},
  callback = function()
    vim.api.nvim_buf_set_option(0, 'commentstring', '// %s')
  end
})
