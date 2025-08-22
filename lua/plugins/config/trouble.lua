require("trouble").setup {
    symbols = {
        desc = "Outline",
        mode = "lsp_document_symbols",
        focus = false,
        win = { position = "right" },
        filter = {
            -- remove Package since luals uses it for control flow structures
            ["not"] = { ft = "lua", kind = "Package" },
            any = {
                -- all symbol kinds for help / markdown files
                ft = { "help", "markdown" },
                -- default set of symbol kinds
                kind = {
                    "Class",
                    "Constructor",
                    "Enum",
                    "Field",
                    "Function",
                    "Interface",
                    "Method",
                    "Module",
                    "Namespace",
                    "Package",
                    "Property",
                    "Struct",
                    "Trait",
                },
            },
        },
    },
}
