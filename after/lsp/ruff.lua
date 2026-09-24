---@type vim.lsp.Config
return {
  on_attach = function(client)
    -- Use basedpyright for symbol documentation.
    client.server_capabilities.hoverProvider = false
  end,
}
