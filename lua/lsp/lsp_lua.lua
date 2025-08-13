local G = require("lsp.general")

local lsp_lua_name = 'lua_ls'
local lsp_lua_config = {
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
      },
      diagnostics = {
        enable = false,
        -- globals = { 'vim' },
        -- disable = { 'inject-field' },
      },
      workspace = {
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
      telemetry = {
        enable = false,
      },
    }
  },
  on_attach = G.lsp_general_on_attach,
  capabilities = G.lsp_capabilities,
}

G.configuration(lsp_lua_name, lsp_lua_config)
