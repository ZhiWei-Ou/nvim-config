local G = require("lsp.general")

return {
    name = 'marksman',
    opts = {
        alias = "Markdown",
        on_attach = G.lsp_general_on_attach,
        filetypes = { "markdown", "md" },
    },
}
