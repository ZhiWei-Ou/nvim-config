local G = require("lsp.general")

local lsp_json_name = 'jsonls'
local lsp_json_config = {
  name = "JSON",
  on_attach = G.lsp_general_on_attach,
  filetypes = { "json", "jsonc" },
}


G.configuration(lsp_json_name, lsp_json_config)
