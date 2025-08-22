local G = require("lsp.general")

local lsp_cmake_name = 'cmake'
local lsp_cmake_config = {
    name = "CMake",
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

}

G.configuration(lsp_cmake_name, lsp_cmake_config)
