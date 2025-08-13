local G = require("lsp.general")

local lsp_markdown_name = 'marksman'
local lsp_markdown_config = {
  name = "Markdown",
  on_attach = G.lsp_general_on_attach,
  filetypes = { "markdown", "md" },
}


G.configuration(lsp_markdown_name, lsp_markdown_config)
