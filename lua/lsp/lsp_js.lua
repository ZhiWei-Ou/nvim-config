--[[
File: lsp_js.lua
Author: Oswin
Email: oswin_ou@intretech.com
Created On: 2025-08-13
Description: 
]]

local G = require("lsp.general")

G.lsp_config.ts_ls.setup {
  name = "JavaScript",
  on_attach = G.lsp_general_on_attach
}
