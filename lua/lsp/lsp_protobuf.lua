local G = require("lsp.general")

G.lsp_config.buf_ls.setup {
  name = "ProtoBuf",
  on_attach = G.lsp_general_on_attach,
  filetypes = { "proto" },
}
