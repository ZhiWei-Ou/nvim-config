local G = require("lsp.general")

G.lsp_config.jsonls.setup {
    name = "JSON",
    on_attach = G.lsp_general_on_attach
}
