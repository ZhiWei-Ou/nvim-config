vim.g.bootstraptype = nil
vim.g.bootstrapsync = nil
local M = {}

function M.startup()
  vim.g.bootstraptype = 'lazy'
  vim.g.bootstrapsync = 'Lazy sync'
  require('lazy_manager')
end

return M
