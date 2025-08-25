--[[
    配置相关的LSP
]]
require("lsp.lsp")


--[[
    LSP 管理器: Mason
    用于管理LSP客户端的安装卸载等
]]
require("mason-lspconfig").setup({
    automatic_enable = true,
    automic_installation = true,
})

-- 光标悬停高亮
vim.o.updatetime = 500 -- CursorHold & CursorHoldI Expect Time (ms)
vim.api.nvim_exec([[
  augroup LspHighlight
    autocmd!
    autocmd CursorHold  *.c,*.h,*.cpp,*.hpp,*.cc,*.hh,*.go,*.lua,*.sh lua vim.lsp.buf.document_highlight()
    autocmd CursorHoldI *.c,*.h,*.cpp,*.hpp,*.cc,*.hh,*.go,*.lua,*.sh lua vim.lsp.buf.document_highlight()
    autocmd CursorMoved *.c,*.h,*.cpp,*.hpp,*.cc,*.hh,*.go,*.lua,*.sh lua vim.lsp.buf.clear_references()
  augroup END
]], false)
