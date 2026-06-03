---@brief AI inline completion via Minuet
---@refer https://github.com/milanglacier/minuet-ai.nvim

return {
  "milanglacier/minuet-ai.nvim",
  enabled = true,
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/nvim-cmp",
  },
  opts = {
    provider = "openai_fim_compatible",
    n_completions = 1,
    context_window = 12000,
    request_timeout = 3,
    throttle = 1000,
    debounce = 500,
    notify = "warn",
    cmp = {
      enable_auto_complete = false,
    },
    lsp = {
      enabled_ft = {},
      completion = {
        enable = false,
      },
      inline_completion = {
        enable = false,
      },
    },
    virtualtext = {
      auto_trigger_ft = { "*" },
      auto_trigger_ignore_ft = {
        "TelescopePrompt",
        "NvimTree",
        "neo-tree",
        "toggleterm",
        "lazy",
        "mason",
        "help",
      },
      keymap = {
        accept = nil,
        accept_line = nil,
        accept_n_lines = nil,
        next = nil,
        prev = nil,
        dismiss = nil,
      },
      show_on_completion_menu = false,
    },
    provider_options = {
      openai_fim_compatible = {
        api_key = "DEEPSEEK_API_KEY",
        name = "Deepseek",
        optional = {
          max_tokens = 128,
          top_p = 0.9,
        },
      },
    },
  },
  config = function(_, opts)
    require("minuet").setup(opts)
  end,
}
