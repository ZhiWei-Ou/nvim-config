--- @brief nvim-comment setup
--- @see https://github.com/numToStr/Comment.nvim
--- @keymaps
--[[
# NORMAL mode
`gcc` - Toggles the current line using linewise comment
`gbc` - Toggles the current line using blockwise comment
`[count]gcc` - Toggles the number of line given as a prefix-count using linewise
`[count]gbc` - Toggles the number of line given as a prefix-count using blockwise
`gc[count]{motion}` - (Op-pending) Toggles the region using linewise comment
`gb[count]{motion}` - (Op-pending) Toggles the region using blockwise comment

# VISUAL mode
`gc` - Toggles the region using linewise comment
`gb` - Toggles the region using blockwise comment
]]
--- @endkeymaps
return {
  "numToStr/Comment.nvim",
  opts = {
    -- add any options here
  },
  config = function()
    require('Comment').setup()
  end,
  lazy = false,
}
