local G = require("lsp.general")

G.lsp_config.yamlls.setup {
  name = "YAML",
  on_attach = G.lsp_general_on_attach
}
