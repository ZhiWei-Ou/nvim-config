-- 安装 LSP 客户端
-- Note: 设置LSP客户端信息在 nvim-lsp.lua文件中

require("mason-lspconfig").setup({
    ensure_installed = { "clangd", "lua_ls", "cmake", "gopls", "jsonls", "marksman", "yamlls", "bashls", "denols", "cssls", "html" },
    automic_installation = true,
})
