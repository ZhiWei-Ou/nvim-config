local G = require("lsp.general")

local lsp_yaml_name = 'yamlls'
local lsp_yaml_config = {
  name = "YAML",
  on_attach = G.lsp_general_on_attach
}

G.configuration(lsp_yaml_name, lsp_yaml_config)
