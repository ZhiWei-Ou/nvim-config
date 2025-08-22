local G = require("lsp.general")

local lsp_shell_name = 'bashls'
local lsp_shell_config = {
    name = "Shell",
    on_attach = G.lsp_general_on_attach
}

G.configuration(lsp_shell_name, lsp_shell_config)
