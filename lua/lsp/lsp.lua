--[[
    all of lsp configurations
]]
require("lsp.lsp_clangd")   -- C/C++
require("lsp.lsp_cmake")    -- CMake
require("lsp.lsp_docker")   -- Dockerfile
require("lsp.lsp_go")       -- Golang
require("lsp.lsp_json")     -- JSON
require("lsp.lsp_lua")      -- Lua
require("lsp.lsp_markdown") -- Markdown
require("lsp.lsp_protobuf") -- Protobuf
require("lsp.lsp_shell")    -- Shell
require("lsp.lsp_yaml")     -- YAML
require("lsp.lsp_frontend") -- Frontend(HTML, CSS, JavaScript, Vue)

vim.api.nvim_create_user_command("Rename", "lua vim.lsp.buf.rename()", { nargs = 0 })
