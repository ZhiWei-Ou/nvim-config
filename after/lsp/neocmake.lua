---@brief
---
--- https://github.com/neocmakelsp/neocmakelsp
---
--- CMake LSP Implementation

---@type vim.lsp.Config
return {
  root_markers = { '.neocmake.toml', 'CMakePresets.json', 'CTestConfig.cmake', '.git', 'build', 'cmake' },
}
