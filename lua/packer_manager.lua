-- Automatically install packer
-- refer to: https://github.com/wbthomason/packer.nvim
--[[
use {
  'myusername/example',        -- The plugin location string
  -- The following keys are all optional
  disable = boolean,           -- Mark a plugin as inactive
  as = string,                 -- Specifies an alias under which to install the plugin
  installer = function,        -- Specifies custom installer. See "custom installers" below.
  updater = function,          -- Specifies custom updater. See "custom installers" below.
  after = string or list,      -- Specifies plugins to load before this plugin. See "sequencing" below
  rtp = string,                -- Specifies a subdirectory of the plugin to add to runtimepath.
  opt = boolean,               -- Manually marks a plugin as optional.
  bufread = boolean,           -- Manually specifying if a plugin needs BufRead after being loaded
  branch = string,             -- Specifies a git branch to use
  tag = string,                -- Specifies a git tag to use. Supports '*' for "latest tag"
  commit = string,             -- Specifies a git commit to use
  lock = boolean,              -- Skip updating this plugin in updates/syncs. Still cleans.
  run = string, function, or table, -- Post-update/install hook. See "update/install hooks".
  requires = string or list,   -- Specifies plugin dependencies. See "dependencies".
  rocks = string or list,      -- Specifies Luarocks dependencies for the plugin
  config = string or function, -- Specifies code to run after this plugin is loaded.
  -- The setup key implies opt = true
  setup = string or function,  -- Specifies code to run before this plugin is loaded. The code is ran even if
                               -- the plugin is waiting for other conditions (ft, cond...) to be met.
  -- The following keys all imply lazy-loading and imply opt = true
  cmd = string or list,        -- Specifies commands which load this plugin. Can be an autocmd pattern.
  ft = string or list,         -- Specifies filetypes which load this plugin.
  keys = string or list,       -- Specifies maps which load this plugin. See "Keybindings".
  event = string or list,      -- Specifies autocommand events which load this plugin.
  fn = string or list          -- Specifies functions which load this plugin.
  cond = string, function, or list of strings/functions,   -- Specifies a conditional test to load this plugin
  module = string or list      -- Specifies Lua module names for require. When requiring a string which starts
                               -- with one of these module names, the plugin will be loaded.
  module_pattern = string/list -- Specifies Lua pattern of Lua module names for require. When
                               -- requiring a string which matches one of these patterns, the plugin will be loaded.
}
]]

local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])


local plugins = {
    -- 管理自身
    { "wbthomason/packer.nvim" },
}

local function _query_all_plugins(folder)
    local config_path = vim.fn.stdpath("config")
    local folder_path = config_path .. "/lua/" .. folder
    local files = vim.fn.glob(folder_path .. "/*.lua", false, true)
    for _, f in ipairs(files) do
        local module = f:match(".*/(.*)%.lua$")
        local p = {require(folder:gsub("/", ".") .. "." .. module)}
        vim.list_extend(plugins, p)
    end
end

_query_all_plugins('plugins')

-- print(vim.inspect(plugins))

local M = {}

function M.startup()
    local status_ok, packer = pcall(require, "packer")
    if not status_ok then
        return
    end

    local build_dir = vim.fn.stdpath("config") .. "/lua/build/packer_compiled.lua"

    packer.init({
        compile_path = build_dir,
        display = {
            open_fn = function()
                return require("packer.util").float({ border = "rounded" })
            end,
        },
    })

    packer.startup({
        function()
            for _, plugin in ipairs(plugins) do
                -- print("Load plugin: " .. vim.inspect(plugin) .. "\n")
                use(plugin)
            end

            if packer_bootstrap then
                require('packer').sync()
            end
        end
    })

    pcall(require, 'build.packer_compiled')
end

return M
