---@brief Centered editing with zen-mode.nvim
---@refer https://github.com/folke/zen-mode.nvim

return {
  "folke/zen-mode.nvim",
  cmd = "ZenMode",
  opts = {
    window = {
      width = 0.75, -- Keep the editor centered at 75% of the available width.
      height = 1,
    },
  },
  keys = {
    { "<leader>z", "<cmd>ZenMode<CR>", desc = "Toggle Zen Mode" },
  },
}
