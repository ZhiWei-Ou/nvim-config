---@brief LSP server installer
---@refer https://github.com/mason-org/mason.nvim

return {
  'williamboman/mason.nvim',
  enabled = true,
  opts = {
    log_level = vim.log.levels.ERROR,
    ui = {
      border = 'rounded',
    },
  },
}
