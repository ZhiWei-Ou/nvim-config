---@brief AI completion via Codeium/Codium

return {
  "Exafunction/codeium.nvim",
  event = "InsertEnter",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  opts = {
    enable_cmp_source = true,
    virtual_text = {
      enabled = true,
      manual = false,
      map_keys = false,
    },
  },
  config = function(_, opts)
    require("codeium").setup(opts)
  end,
}
