--[[
File: lsp_css.lua
Author: Oswin
Email: oswin_ou@intretech.com
Created On: 2025-08-13
Description: 
]]

local G = require("lsp.general")

G.lsp_config.cssls.setup {
  name = "CSS",
  on_attach = G.lsp_general_on_attach
}
