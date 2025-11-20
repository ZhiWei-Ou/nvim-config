---@brief
---
--- https://github.com/regen100/cmake-language-server
---
--- CMake LSP Implementation

---@type vim.lsp.Config
vim.lsp.config('cmake', {
    cmd = { 'cmake-language-server' },
    filetypes = { 'cmake' },
    root_markers = { 'CMakePresets.json', 'CTestConfig.cmake', '.git', 'build', 'cmake' },
    init_options = {
        buildDirectory = 'build',
    },
    on_init = function(client, init_result)
        client.alias_name = 'CMake(cmake)'
    end
})
