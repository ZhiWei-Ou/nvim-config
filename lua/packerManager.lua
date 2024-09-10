-- !!! 安装这个插件，只是为了配合 Mason的Filter功能显示出来可以是一个浮动窗口
--
local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
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

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})


local plugins = {
    -- 管理自身
    {
        "wbthomason/packer.nvim"
    },

    -- nvim-mason
    {
        "williamboman/mason.nvim",
        config = function()
            require("config.nvim-mason")
        end
    },

    -- nvim-tree
    {
        "nvim-tree/nvim-tree.lua",
        config = function()
            require("config.tree")
        end
    },

    -- nvim-web-devicons
    {
        "nvim-tree/nvim-web-devicons",
        config = function()
            require("config.nvim-web-devicons")
        end
    },

    -- nvim-gitsigns
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("config.nvim-gitsigns")
        end
    },

    -- nvim-treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            require("config.nvim-treesitter")
        end,
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    },

    -- nvim-surround
    {
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround")
        end
    },

    -- nvim-telescope
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        requires = {
            {'nvim-lua/plenary.nvim'}
        },
        config = function()
            require("config.nvim-telescope")
        end,
    },

    -- nvim-notice
    -- {
    --     "folke/noice.nvim",
    --     requires = {
    --         "MunifTanjim/nui.nvim",
    --         "rcarriga/nvim-notify",
    --     },
    --     config = function()
    --         require("config.nvim-notice")
    --     end
    -- },

    -- nvim-bufferline
    {
        'akinsho/bufferline.nvim',
        tag = "*",
        requires = 'nvim-tree/nvim-web-devicons',
        config = function()
            require("config.nvim-bufferline")
        end
    },

    -- nvim-spectre
    {
        'windwp/nvim-spectre',
        config = function()
            require("config.nvim-spectre")
        end
    },

    -- nvim-toggleterm
    {
        "akinsho/toggleterm.nvim",
        tag = '*',
        config = function()
            require("config.nvim-toggleterm")
        end
    },

    -- nvim-github-theme
    {
        'projekt0n/github-nvim-theme' ,
        config = function()
            require("config.nvim-github-theme")
        end,
        run = function()
            vim.cmd('colorscheme github_dark_dimmed')
        end
    },

    -- nvim-ouroboros
    {
        'jakemason/ouroboros',
        config = function()
            require("config.nvim-ouroboros")
        end,
        requires = { {'nvim-lua/plenary.nvim'} },
    },

    -- nvim-cmp
    {
        "hrsh7th/nvim-cmp",
        requires = {
            {"hrsh7th/cmp-nvim-lsp"},
            {"hrsh7th/cmp-buffer"},
            {"hrsh7th/cmp-path"},
            {"hrsh7th/cmp-cmdline"},
            {"saadparwaiz1/cmp_luasnip"},
            {"hrsh7th/cmp-nvim-lua"},
            {"onsails/lspkind-nvim"},
        },
        config = function()
            require("config.nvim-cmp")
        end
    },

    -- nvim-codeium
    {
        'Exafunction/codeium.vim',
        config = function()
            require("config.nvim-codeium")
        end
    },


    -- nvim-mason-lspconfig
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("config.nvim-mason-lspconfig")
        end
    },

    -- nvim-lspconfig
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("config.nvim-lsp")
        end
    },


    -- vim-visual-multi
    {
        'mg979/vim-visual-multi'
    },

    -- cmake-tools
    {
        'Civitasv/cmake-tools.nvim',
        config = function()
            require("config.nvim-cmake-tools")
        end
    },

    -- dress
    -- With the release of Neovim 0.6 we were given the start of extensible core UI hooks (vim.ui.select and vim.ui.input).
    -- They exist to allow plugin authors to override them with improvements upon the default behavior, so that's exactly what we're going to do.
    {
        'stevearc/dressing.nvim',
        config = function()
            require("config.nvim-dressing")
        end
    },

    -- Lua-Snip
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!:).
        run = "make install_jsregexp",
        config = function()
            require("config.nvim-luasnip")
        end
    }, { 'saadparwaiz1/cmp_luasnip' },
    -- lualine
    {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true },
        config = function()
            require("config.nvim-lualine")
        end
    },
}

-- Install your plugins here
return packer.startup({
    function()
	    for _, plugin in ipairs(plugins) do
		    use(plugin)
            -- input plugin name
            -- print(plugin[1])
	    end

        if packer_bootstrap then
            require('packer').sync()
        end
    end
})

