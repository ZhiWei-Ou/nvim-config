local G = require("lsp.general")

G.lsp_config.bashls.setup {
  name = "Shell",
  on_attach = G.lsp_general_on_attach
}
