--lua/plugins/copilot.lua
---@brief The configuration for GitHub Copilot using the 'copilot.lua' plugin.
---@date 2025-12-15
return {
  "zbirenbaum/copilot.lua",
  requires = {
    "copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
  },
  cmd = "Copilot",
  event = "InsertEnter",
  opts = {
    panel = {
      enabled = true,
      auto_refresh = false,
      keymap = {
        jump_prev = "[[",
        jump_next = "]]",
        accept = "<CR>",
        refresh = "gr",
        open = "<M-CR>"
      },
      layout = {
        position = "bottom", -- | top | left | right | bottom |
        ratio = 0.4
      },
    },
    suggestion = {
      enabled = true,
      auto_trigger = true,
      hide_during_completion = true,
      debounce = 75,
      trigger_on_accept = true,
      keymap = {
        accept = "<TAB>",
        accept_word = false,
        accept_line = false,
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
    },
    nes = {
      enabled = false, -- requires copilot-lsp as a dependency
      auto_trigger = false,
      keymap = {
        accept_and_goto = false,
        accept = false,
        dismiss = false,
      },
    },
    auth_provider_url = nil, -- URL to authentication provider, if not "https://github.com/"
    logger = {
      file = vim.fn.stdpath("log") .. "/copilot-lua.log",
      file_log_level = vim.log.levels.OFF,
      print_log_level = vim.log.levels.WARN,
      trace_lsp = "off", -- "off" | "messages" | "verbose"
      trace_lsp_progress = false,
      log_lsp_messages = false,
    },
    copilot_node_command = 'node', -- Node.js version must be > 22
    workspace_folders = {},
    copilot_model = "",
    disable_limit_reached_message = false, -- Set to `true` to suppress completion limit reached popup
    root_dir = function()
      return vim.fs.dirname(vim.fs.find(".git", { upward = true })[1])
    end,
    should_attach = function(_, _)
      if not vim.bo.buflisted then
        -- vim.notify("not attaching, buffer is not 'buflisted'", vim.log.levels.WARN, nil)
        return false
      end

      if vim.bo.buftype ~= "" then
        vim.notify("not attaching, buffer 'buftype' is " .. vim.bo.buftype, vim.log.levels.WARN, nil)
        return false
      end

      return true
    end,
    server = {
      type = "nodejs", -- "nodejs" | "binary"
      custom_server_filepath = nil,
    },
    server_opts_overrides = {},
  },
  config = function(_, opts)
    require("copilot").setup(opts)
  end,
}
