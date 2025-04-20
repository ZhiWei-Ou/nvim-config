local G = require("lsp.general")

G.lsp_config.cmake.setup {
  name = "CMake",
  on_attach = G.lsp_general_on_attach
}
