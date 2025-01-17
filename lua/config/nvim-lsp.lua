-- 设置 LSP 客户端
local lspconfig = require('lspconfig')

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- 1. label_clangd
-- 2. label_cmake
-- 3. label_lua_ls
-- 4. label_gopls
-- 5. label_jsonls
-- 6. marksman
-- 7. label_yamlls
-- 8. label_bashls
-- 10. label_denols
-- 11. label_cssls
-- 12. label_html
-- 13. label_buf_ls
-- 14. label_dockerls

-- 配置 LSP 快捷键
local on_attach = function(client, bufnr)

    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
        vim.lsp.handlers['signature_help'],
        {
            border = 'single',
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
            border = 'double',  --  'single', 'double', 'rounded', 'solid', 'shadow'
        }
    )

    vim.lsp.handlers["textDocument/references"] = vim.lsp.with(
        vim.lsp.handlers.references,
        {
            border = 'double',
        }
    )

end

lspconfig.clangd.setup{
    name = "C/C++", -- actual 'Clangd'
    cmd = {
        'clangd',
        '--background-index',
        '--header-insertion=never',
    },
    filetypes = {
        "c", "cpp", "objc", "objcpp", "cc",
        "hh", "hpp", "h", "hxx"
    },
    handlers = {
        ["textDocument/hover"] = vim.lsp.with(
            vim.lsp.handlers.hover,
            {
                border = 'double',  --  'single', 'double', 'rounded', 'solid', 'shadow'
            }
        ),
        ["textDocument/signatureHelp"] = vim.lsp.with(
            vim.lsp.handlers.signature_help,
            {
                border = 'double',  --  'single', 'double', 'rounded', 'solid', 'shadow'
                close_events = {
                    'CursorMoved',
                    'BufHidden',
                    'InsertCharPre'
                },
            }
        ),
        ['textDocument/references'] = vim.lsp.with(
            vim.lsp.handlers.references,
            {
                border = "double",
                loclist = true,
            }
        ),
    }
}
-- label_clangd endl


-- label_cmake
lspconfig.cmake.setup {
  name = "CMake",
  on_attach = on_attach
}
-- label_cmake endl


-- label_lua_ls
lspconfig.lua_ls.setup {
    name = "Lua",
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                diagnostics = {
                    'vim',
                    'describe',
                    'it',
                    'before_each',
                    'after_each',
                    'pending',
                }
            }
        }
    },
    on_attach = on_attach,
    capabilities = capabilities,

}
-- label_lua_ls endl

-- label_gopls
lspconfig.gopls.setup {
    name = "Go",
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        gopls = {
            gofumpt = true,
            codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
            },
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
            analyses = {
                fieldalignment = true,
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
            },
            usePlaceholders = true,
            completeUnimported = true,
            staticcheck = true,
            directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
            semanticTokens = true,

            -- analyses = {
            --     unusedparams = true,
            -- },
            -- staticcheck = true,
            -- gofumpt = true,
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
    name = "JSON",
    on_attach = on_attach
}
-- label_jsonls endl

-- label_marksman
lspconfig.marksman.setup {
    name = "Markdown",
    on_attach = on_attach
}
-- label_marksman endl

-- label_yamlls
lspconfig.yamlls.setup {
    name = "YAML",
    on_attach = on_attach
}
-- label_yamlls endl

-- label_bashls
lspconfig.bashls.setup {
    name = "Shell",
    on_attach = on_attach
}
-- label_bashls endl    

-- label_denols
lspconfig.denols.setup {
  on_attach = on_attach,
  filetypes = { "ts", "tsx", "js", "jsx", "cjs", "mjs", "ts", "tsx", "json" },
}
-- label_denols endl

-- label_cssls
lspconfig.cssls.setup {
  on_attach = on_attach
}
-- label_cssls endl

-- label_html
lspconfig.html.setup {
  on_attach = on_attach
}
-- label_html endl

-- label_buf_ls
require'lspconfig'.buf_ls.setup{
    name = "ProtoBuf",
    on_attach = on_attach,
    filetypes = { "proto" },
}
-- label_buf_ls endl

-- label_dockerls
lspconfig.dockerls.setup {
    name = "Docker",
    on_attach = on_attach
}
-- label_dockerls endl

vim.o.updatetime = 500  -- CursorHold & CursorHoldI Expect Time (ms)
vim.api.nvim_exec([[
  augroup LspHighlight
    autocmd!
    autocmd CursorHold  *.c,*.h,*.cpp,*.hpp,*.cc,*.hh,*.go,*.lua,*.sh lua vim.lsp.buf.document_highlight()
    autocmd CursorHoldI *.c,*.h,*.cpp,*.hpp,*.cc,*.hh,*.go,*.lua,*.sh lua vim.lsp.buf.document_highlight()
    autocmd CursorMoved *.c,*.h,*.cpp,*.hpp,*.cc,*.hh,*.go,*.lua,*.sh lua vim.lsp.buf.clear_references()
  augroup END
]], false)
