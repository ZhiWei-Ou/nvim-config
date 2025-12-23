---@brief mason lspconfig plugin
---@refer https://github.com/mason-org/mason-lspconfig.nvim

return {
  'mason-org/mason-lspconfig.nvim',
  dependencies = {
    { "mason-org/mason.nvim",  opts = {} },
    { "neovim/nvim-lspconfig", },
  },
  opts = {
    automatic_enable = true,
  },
  config = function(_, opts)
    require("mason-lspconfig").setup(opts)
  end
}
