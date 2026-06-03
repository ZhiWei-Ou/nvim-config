---@brief AI completion via Github Copilot
---@refer https://github.com/github/copilot.vim

return {
  "github/copilot.vim",
  enabled = false,
  event = "InsertEnter",
  config = function()
    vim.g.copilot_no_tab_map = false
    vim.g.copilot_assume_mapped = true
  end,
}
