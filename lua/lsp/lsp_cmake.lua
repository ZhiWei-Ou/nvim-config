---@brief
---
--- https://github.com/regen100/cmake-language-server
---
--- CMake LSP Implementation

return {
    name = 'cmake',
    opts = {
        filetypes = { 'cmake' },
        init_options = { buildDirectory = "build" },
        root_markers = { 'CMakePresets.json', 'CTestConfig.cmake', '.git', 'build', 'cmake' },
        on_init = function (c, i)
            c.alias_name = 'CMake(cmake)'
        end
    },
}
