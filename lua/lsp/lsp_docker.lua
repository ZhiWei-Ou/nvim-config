local G = require("lsp.general")

return {
    name = 'dockerls',
    opts = {
        alias = "Docker",
        on_attach = G.lsp_general_on_attach
    },
}

