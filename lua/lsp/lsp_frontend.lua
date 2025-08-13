--[[
  File: lsp_frontend.lua
  Author: Oswin
  Email: oswin_ou@intretech.com
  Created On: 2025-08-13
  Description: 前端LSP配置，HTML, CSS, JavaScript, Vue
  @Brief: https://github.com/vuejs/language-tools/wiki/Neovim
]]
local G = require("lsp.general")

local TypeScriptName = 'javascript'
local JavascriptName = 'javascript'
local vue_language_server_path = vim.fn.expand '$MASON/packages' .. '/vue-language-server' .. '/node_modules/@vue/language-server'
local tsserver_filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }

local vue_plugin = {
  name = '@vue/typescript-plugin',
  location = vue_language_server_path,
  languages = { 'vue' },
  configNamespace = 'typescript',
}

local ts_ls_config = {
  name = JavascriptName,
  init_options = {
    plugins = {
      vue_plugin,
    },
  },
  filetypes = tsserver_filetypes,
  on_attach = G.lsp_general_on_attach,
}

-- If you are not on most recent `nvim-lspconfig` or you want to override
local vue_ls_config = {
  on_init = function(client)
    client.handlers['tsserver/request'] = function(_, result, context)
      local ts_clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = JavascriptName })
      local clients = {}

      vim.list_extend(clients, ts_clients)

      if #clients == 0 then
        vim.notify('Could not find `vtsls` or `ts_ls` lsp client, `vue_ls` would not work without it.', vim.log.levels.ERROR)
        return
      end
      local ts_client = clients[1]

      local param = unpack(result)
      local id, command, payload = unpack(param)
      ts_client:exec_cmd({
        title = 'vue_request_forward', -- You can give title anything as it's used to represent a command in the UI, `:h Client:exec_cmd`
        command = 'typescript.tsserverRequest',
        arguments = {
          command,
          payload,
        },
      }, { bufnr = context.bufnr }, function(_, r)
          local response = r and r.body
          -- TODO: handle error or response nil here, e.g. logging
          -- NOTE: Do NOT return if there's an error or no response, just return nil back to the vue_ls to prevent memory leak
          local response_data = { { id, response } }

          ---@diagnostic disable-next-line: param-type-mismatch
          client:notify('tsserver/response', response_data)
        end)
    end
  end,
}

local html_config = {
  name = "html",
  on_attach = G.lsp_general_on_attach,
}

local css_config = {
  name = "css",
  on_attach = G.lsp_general_on_attach,
}

G.lsp_config.ts_ls.setup(ts_ls_config)
G.lsp_config.html.setup(html_config)
G.lsp_config.cssls.setup(css_config)

--[[
  vue_ls was renamed from **volar** in nvim-lspconfig and mason Mason PR:
  https://github.com/mason-org/mason-lspconfig.nvim/pull/561
  nvim-lspconfig PR: https://github.com/neovim/nvim-lspconfig/pull/3843
]]
G.lsp_config.volar.setup(vue_ls_config)

