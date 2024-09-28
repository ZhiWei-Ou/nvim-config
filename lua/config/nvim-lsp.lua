-- 设置 LSP 客户端
local lspconfig = require('lspconfig')

-- 1. label_clangd
-- 2. label_cmake
-- 3. label_lua_ls
-- 4. label_gopls
-- 5. label_jsonls
-- 6. marksman
-- 7. label_yamlls
-- 8. label_bashls
-- 9. label_bufls

-- label_clangd
-- 配置 clangd 语言服务器
lspconfig.clangd.setup{}
-- 配置 LSP 快捷键
local on_attach = function(client, bufnr)
  local buf_set_keymap = function(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local opts = { noremap=true, silent=true }

  -- 定义 gd 跳转到定义
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  
  -- 定义 gh 显示悬停信息
  buf_set_keymap('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)

  -- 定义 gr 显示引用
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

  -- 定义 gt 显示类型
  buf_set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
end
-- 将 on_attach 传递给语言服务器设置
lspconfig.clangd.setup{
  on_attach = on_attach,
}
-- label_clangd endl


-- label_cmake
lspconfig.cmake.setup {
  on_attach = on_attach
}
-- label_cmake endl


-- label_lua_ls
lspconfig.lua_ls.setup {
}
-- label_lua_ls endl

-- label_gopls
lspconfig.gopls.setup {
  on_attach = on_attach,
  settings = {
      gopls = {
          analyses = {
              unusedparams = true,
          },
          staticcheck = true,
          gofumpt = true,
      },
  },
}
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
        -- tidy go imports on save
          local params = vim.lsp.util.make_range_params()
          params.context = { only = { "source.organizeImports" } }
          local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
          for _, res in pairs(result or {}) do
            for _, r in pairs(res.result or {}) do
              if r.edit then
                vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
              end
            end
          end
        -- Save File then format code
        vim.lsp.buf.format({ async = false })
    end,
    buffer = bufnr,
})
-- label_gopls endl


-- label_jsonls
lspconfig.jsonls.setup {
  on_attach = on_attach
}
-- label_jsonls endl

-- label_marksman
lspconfig.marksman.setup {
  on_attach = on_attach
}
-- label_marksman endl

-- label_yamlls
lspconfig.yamlls.setup {
  on_attach = on_attach
}
-- label_yamlls endl

-- label_bashls
lspconfig.bashls.setup {
  on_attach = on_attach
}
-- label_bashls endl    

-- label_bufls
lspconfig.bufls.setup {
  on_attach = on_attach,
  filetypes = { "proto" },
}
-- label_bufls endl
