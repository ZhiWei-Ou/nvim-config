local G = require("lsp.general")

G.lsp_config.dockerls.setup {
  name = "Docker",
  on_attach = G.lsp_general_on_attach
}
