---@brief mason lspconfig plugin
---@refer https://github.com/mason-org/mason-lspconfig.nvim

local servers = {
  'bashls',
  'basedpyright',
  'buf_ls',
  'clangd',
  'neocmake',
  'gopls',
  'jsonls',
  'lua_ls',
  'marksman',
  'ruff',
  'yamlls',
}

return {
  'mason-org/mason-lspconfig.nvim',
  enabled = true,
  dependencies = {
    { "mason-org/mason.nvim",  opts = {} },
    { "neovim/nvim-lspconfig", },
  },
  opts = {
    ensure_installed = servers,
    automatic_enable = servers,
  },
  config = function(_, opts)
    require("mason-lspconfig").setup(opts)
  end
}
