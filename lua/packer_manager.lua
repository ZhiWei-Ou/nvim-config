-- Automatically install packer
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
vim.list_extend(plugins, require("plugins.plugin_list"))

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
