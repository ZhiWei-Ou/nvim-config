---@brief detect buffer indentation settings automatically
---@refer https://github.com/tpope/vim-sleuth

return {
  "tpope/vim-sleuth",
  enabled = true,
  event = { "BufReadPost", "BufNewFile" },
}
