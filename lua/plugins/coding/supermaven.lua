---@brief AI inline completion via Supermaven
---@refer https://github.com/supermaven-inc/supermaven-nvim

return {
  "supermaven-inc/supermaven-nvim",
  enabled = true,
  event = "InsertEnter",
  opts = {
    disable_keymaps = true,
    disable_inline_completion = false,
    ignore_filetypes = {
      TelescopePrompt = true,
      NvimTree = true,
      ["neo-tree"] = true,
      toggleterm = true,
      lazy = true,
      mason = true,
      help = true,
    },
    log_level = "warn",
  },
  config = function(_, opts)
    require("supermaven-nvim").setup(opts)
  end,
}
