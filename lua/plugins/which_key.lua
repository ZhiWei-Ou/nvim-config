return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- your configuration comes herewhic
    -- or leave it empty to use the default settingswhi
    -- refer to the configuration section below
    preset = "helix", -- classic | modern | helix
    delay = 1000,
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
