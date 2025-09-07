local G = require("lsp.general")

local lsp_protobuf_name = 'buf'
local lsp_protobuf_config = {
    name = "ProtoBuf",
    on_attach = G.lsp_general_on_attach,
    filetypes = { "proto" },
}

G.configuration(lsp_protobuf_name, lsp_protobuf_config)
