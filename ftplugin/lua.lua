vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2

local ok, _ = pcall(require, 'conform')
if ok then
  local found = vim.fs.find('.stylua.toml', { upward = true, type = 'file' })
  if not vim.tbl_isempty(found) then
    vim.b.conform_enable = true
  else
    vim.b.conform_enable = false
  end
end
