---@breif lazy.nvim plugin manager
---@refer https://lazy.folke.io/usage/migration

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local function is_lite_mode()
  return vim.g.lite_mode == true
end

-- Plugin groups, each a directory under `lua/plugins/`
local plugin_groups = { "ui", "editor", "coding", "lsp", "treesitter", "lang", "util" }

-- Curated subset loaded in lite mode
local lite_plugins = {
  "plugins.ui.theme",
  "plugins.ui.nvim_web_devicons",
  "plugins.editor.nvim_tree",
  "plugins.editor.telescope",
  "plugins.editor.leap",
  "plugins.editor.gitsigns",
  "plugins.editor.vim_sleuth",
  "plugins.util.plenary",
}

local function plugin_spec()
  local modules = is_lite_mode() and lite_plugins or vim.tbl_map(function(group)
    return "plugins." .. group
  end, plugin_groups)
  return vim.tbl_map(function(module)
    return { import = module }
  end, modules)
end

-- Setup lazy.nvim
require("lazy").setup({
  spec = plugin_spec(),
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  ui = {
    border = "rounded",
  },
  -- automatically check for plugin updates
  checker = { enabled = false },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = false,
    notify = false, -- get a notification when changes are found
  },
})

-- Local plugins tracked as git submodules under `plugins/`
local grayveil_path = vim.fn.stdpath("config") .. "/plugins/grayveil.nvim"
if (vim.uv or vim.loop).fs_stat(grayveil_path) then
  vim.opt.rtp:prepend(grayveil_path)
  require("grayveil").setup({
    transparent = false,
    terminal_colors = true,
  })
end
