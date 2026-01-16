-- lua/core/autocmds.lua
---@brief 自动命令
---@date 2025-12-11

---@section
---@brief Highlight symbol under cursor
vim.o.updatetime = 500 -- CursorHold & CursorHoldI Expect Time (ms)
local lsp_highlight_group = vim.api.nvim_create_augroup('LspHighlight', { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
  group = lsp_highlight_group,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client or not client.server_capabilities.documentHighlightProvider then
      return
    end

    local bufnr = args.buf
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      group = lsp_highlight_group,
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
      desc = "Highlight symbol under cursor",
    })
    vim.api.nvim_create_autocmd('CursorMoved', {
      group = lsp_highlight_group,
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
      desc = "Clear symbol highlights",
    })
  end,
  desc = "Setup LSP document highlight autocmds",
})
---@endsection
