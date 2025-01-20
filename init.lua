require("global")
require("packerManager")
require("keymaps")

vim.cmd('colorscheme github_light_default')

vim.api.nvim_create_autocmd("FileType", {
  -- pattern = {"*.c", "*.h", "*.cpp", "*.hpp", "*.tpp", "*.cc", "*.hh"},
  pattern = {'c', 'h', 'cpp', 'hpp', 'tpp', 'cc', 'hh'},
  callback = function()
    vim.api.nvim_buf_set_option(0, 'commentstring', '// %s')
  end
})

--  get os information
-- print(vim.inspect(vim.loop.os_uname()))
--
-- output: 
-- {
--   machine = "arm64",
--   release = "24.0.0",
--   sysname = "Darwin",
--   version = "Darwin Kernel Version 24.0.0: Mon Aug 12 20:52:18 PDT 2024; root:xnu-11215.1.10~2/RELEASE_ARM64_T8122"
-- } 

