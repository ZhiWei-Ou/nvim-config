local M = {}

M.lsp_config = require('lspconfig')
M.lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

function M.configuration(name, config)
  vim.lsp.config(name, config)
end

function M.lsp_general_on_attach(client, bufnr)
  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers['signature_help'],
    {
      border = 'rounded',
      close_events = {
        'CursorMoved',
        'BufHidden',
        'InsertCharPre'
      },
    }
  )

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover,
    {
      winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder',
      border = 'rounded',       --  'single', 'double', 'rounded', 'solid', 'shadow'
    }
  )

  vim.lsp.handlers["textDocument/references"] = vim.lsp.with(
    vim.lsp.handlers.references,
    {
      winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder',
      border = 'rounded',       --  'single', 'double', 'rounded', 'solid', 'shadow'
    }
  )
end

return M
