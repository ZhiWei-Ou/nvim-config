--[[
File: lsp_html.lua
Author: Oswin
Email: oswin_ou@intretech.com
Created On: 2025-08-13
Description: 
]]

local G = require("lsp.general")

G.lsp_config.html.setup {
  name = "HTML",
  on_attach = G.lsp_general_on_attach
}
