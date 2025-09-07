local G = require("lsp.general")

local lsp_docker_name = 'dockerls'
local lsp_docker_config = {
    name = "Docker",
    on_attach = G.lsp_general_on_attach
}

G.configuration(lsp_docker_name, lsp_docker_config)
