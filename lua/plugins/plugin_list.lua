local Mason = {
    "williamboman/mason.nvim",
    config = function()
        require('plugins.config.mason')
    end
}

local NvimTree = {
    "nvim-tree/nvim-tree.lua",
    config = function()
        require('plugins.config.nvim_tree')
    end
}

local NvimWebDevIcons = {
    "nvim-tree/nvim-web-devicons",
    config = function()
        require("plugins.config.nvim_web_icon")
    end
}

local GitSigns = {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("plugins.config.gitsigns")
    end
}

local NvimTreeSitter = {
    'nvim-treesitter/nvim-treesitter',
    config = function()
        require("plugins.config.nvim_treesitter")
    end,
    run = function()
        local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
        ts_update()
    end,
}

local Telescope = {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    requires = {
        { 'nvim-lua/plenary.nvim' }
    },
    config = function()
        require("plugins.config.telescope")
    end,
}

local BufferLine = {
    'akinsho/bufferline.nvim',
    tag = "*",
    requires = 'nvim-tree/nvim-web-devicons',
    config = function()
        require("plugins.config.bufferline")
    end
}

local Spectre = {
    'windwp/nvim-spectre',
    config = function()
        require("plugins.config.nvim_spectre")
    end
}

local ToggleTerm = {
    "akinsho/toggleterm.nvim",
    tag = '*',
    config = function()
        require("plugins.config.toggleterm")
    end
}

local GithubNvimTheme = {
    'projekt0n/github-nvim-theme',
}

local Ouroboros = {
    'jakemason/ouroboros',
    config = function()
        require("plugins.config.ouroboros")
    end,
    requires = { { 'nvim-lua/plenary.nvim' } },
}

local NvimCMP = {
    "hrsh7th/nvim-cmp",
    requires = {
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "hrsh7th/cmp-cmdline" },
        { "saadparwaiz1/cmp_luasnip" },
        { "hrsh7th/cmp-nvim-lua" },
        { "onsails/lspkind-nvim" },
    },
    config = function()
        require("plugins.config.nvim_cmp")
    end
}

local Windsurf = {
    'Exafunction/windsurf.vim',
    config = function()
        require("plugins.config.windsurf")
    end
}

local NvimMasonLspConfig = {
    "williamboman/mason-lspconfig.nvim",
    after = "mason.nvim",
    config = function()
        -- Nothing ToDo
    end
}

local NvimLspConfig = {
    "neovim/nvim-lspconfig",
    after = "mason-lspconfig.nvim",
    config = function()
        require("plugins.config.nvim_lsp")
    end
}

local NvimAdapter = {
    "mfussenegger/nvim-dap",
    config = function()
        require("plugins.config.nvim_dap")
    end
}

local VimVisualMulti = {
    'mg979/vim-visual-multi'
}

local CmakeTools = {
    'Civitasv/cmake-tools.nvim',
    config = function()
        require("plugins.config.cmake_tools")
    end
}

local Dressing = {
    'stevearc/dressing.nvim',
    config = function()
        require("plugins.config.dressing")
    end
}

local LuaSnip = {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!:).
    run = "make install_jsregexp",
    config = function()
        require("plugins.config.luasnip")
    end
}
local CmpLuaSnip = {
    'saadparwaiz1/cmp_luasnip'
}

local LuaLine = {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true },
    config = function()
        require("plugins.config.lualine")
    end
}

local Dashboard = {
    'nvimdev/dashboard-nvim',
    config = function()
        require('plugins.config.dashboard')
    end,
    requires = { 'nvim-tree/nvim-web-devicons' },
    event = 'VimEnter',
}

local TokyoNightTheme = {
    'folke/tokyonight.nvim'
}

local KanagawaTheme = {
    'rebelot/kanagawa.nvim'
}

local RenderMarkdown = {
    'MeanderingProgrammer/render-markdown.nvim',
    after = { 'nvim-treesitter' },
    requires = { 'echasnovski/mini.nvim', opt = true }, -- if you use the mini.nvim suite
    config = function()
        require('render-markdown').setup({})
    end,
}

local Leap = {
    'ggandor/leap.nvim',
    config = function()
        require('plugins.config.leap')
    end
}

local Scrollbar = {
    'petertriho/nvim-scrollbar',
    config = function()
        require('plugins.config.nvim_scrollbar')
    end
}

local Trouble = {
    'folke/trouble.nvim',
    requires = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('plugins.config.trouble')
    end,
}

local CatppuccinTheme = {
    'catppuccin/nvim',
    as = 'catppuccin',
}

local IndentBlankLine = {
    'lukas-reineke/indent-blankline.nvim',
    tag = 'v3.8.2',
    enabled = true,
    main = 'ibl',
    opts = {},
    dependencies = {
        { 'HiPhish/rainbow-delimiters.nvim', lazy = true },
    },
    config = function()
        require('plugins.config.indent_blankline')
    end
}

local Confrom = {
    'stevearc/conform.nvim',
    config = function()
        require('plugins.config.conform')
    end
}

return {
    Mason,
    NvimTree,
    NvimWebDevIcons,
    GitSigns,
    NvimTreeSitter,
    Telescope,
    BufferLine,
    Spectre,
    ToggleTerm,
    GithubNvimTheme,
    Ouroboros,
    NvimCMP,
    Windsurf,
    NvimMasonLspConfig,
    NvimLspConfig,
    NvimAdapter,
    VimVisualMulti,
    CmakeTools,
    Dressing,
    LuaSnip,
    CmpLuaSnip,
    LuaLine,
    Dashboard,
    TokyoNightTheme,
    RenderMarkdown,
    Leap,
    Scrollbar,
    Trouble,
    CatppuccinTheme,
    KanagawaTheme,
    IndentBlankLine,
    Confrom
}
