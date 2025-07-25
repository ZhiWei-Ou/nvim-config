local G = require("lsp.general")

G.lsp_config.marksman.setup {
  name = "Markdown",
  on_attach = G.lsp_general_on_attach
}
