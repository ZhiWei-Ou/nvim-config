--- @brief: Highlight symbol under cursor

vim.o.updatetime = 500 -- CursorHold & CursorHoldI Expect Time (ms)
local lsp_highlight_group = vim.api.nvim_create_augroup('LspHighlight', { clear = true })
local file_patterns = { "*.c", "*.h", "*.cpp", "*.hpp", "*.cc", "*.hh", "*.go", "*.lua", "*.sh" }
vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
  group = lsp_highlight_group,
  pattern = file_patterns,
  callback = vim.lsp.buf.document_highlight,
  desc = "Highlight symbol under cursor",
})
vim.api.nvim_create_autocmd({ 'CursorMoved' }, {
  group = lsp_highlight_group,
  pattern = file_patterns,
  callback = vim.lsp.buf.clear_references,
  desc = "Clear symbol highlights",
})
