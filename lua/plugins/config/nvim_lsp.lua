--[[
    配置相关的LSP
]]
require("lsp.lsp_clangd")
require("lsp.lsp_cmake")
require("lsp.lsp_docker")
require("lsp.lsp_go")
require("lsp.lsp_json")
require("lsp.lsp_lua")
require("lsp.lsp_markdown")
require("lsp.lsp_protobuf")
require("lsp.lsp_shell")
require("lsp.lsp_yaml")
require("lsp.lsp_vim")

--[[
    LSP 管理器: Mason
    用于管理LSP客户端的安装卸载等
]]
require("mason-lspconfig").setup({
  ensure_installed = {
    "clangd",
    "lua_ls",
    "cmake",
    "gopls",
    "jsonls",
    "marksman",
    "yamlls",
    "bashls",
    "vimls",
  },
  automatic_enable = false,
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
