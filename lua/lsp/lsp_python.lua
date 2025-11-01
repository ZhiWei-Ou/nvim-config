local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("ruff", {
  -- Optional: If you want to use Ruff exclusively for linting and formatting,
  -- you can disable other capabilities to avoid conflicts with your primary LSP.
  on_attach = function(client, bufnr)
    if client.name == "ruff_lsp" then
      client.server_capabilities.hoverProvider = false
      client.server_capabilities.definitionProvider = false
    end
  end,
})

vim.lsp.config("pylsp", {
  capabilities = capabilities,
  settings = {
    pylsp = {
      plugins = {
        -- Disable some default plugins if you're using other tools
        pycodestyle = { enabled = false },
        pyflakes = { enabled = false },
        -- Enable plugins for other tools
        ruff = { enabled = true },
        black = { enabled = true },
      },
    },
  },
})
