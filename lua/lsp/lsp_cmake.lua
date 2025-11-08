local G = require("lsp.general")

return {
    name = 'cmake',
    opts = {
        alias = "CMake",
        on_attach = G.lsp_general_on_attach,
        filetypes = {
            "cmake"
        },
        init_options = {
            buildDirectory = "build"
        },
        root_markers = {
            'CMakePresets.json',
            'CTestConfig.cmake',
            '.git',
            'build',
            'cmake'
        }
    },
}
