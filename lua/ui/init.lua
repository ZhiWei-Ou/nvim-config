-- lua/ui/init.lua
---@brief ui module
---@date 2025-12-17
local X = {}

function X.get_logo()
  return require('ui.logo_mgnr').get_logo_from_config()
end

return X
