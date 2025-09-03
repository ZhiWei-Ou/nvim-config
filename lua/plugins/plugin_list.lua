local mason = {
    "williamboman/mason.nvim",
    config = function()
        require('plugins.config.mason')
    end,
    summary = "LSP Server Installer"
}

local nvimtree = {
    "nvim-tree/nvim-tree.lua",
    config = function()
        require('plugins.config.nvim_tree')
    end,
    summary = "File Explorer"
}

local nvimwebdevicons = {
    "nvim-tree/nvim-web-devicons",
    config = function()
        require("plugins.config.nvim_web_icon")
    end,
    summary = "File Icons"
}

local gitsigns = {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("plugins.config.gitsigns")
    end,
    summary = "Git Integration"
}

local nvimtreesitter = {
    'nvim-treesitter/nvim-treesitter',
    branch = "main",
    config = function()
        require("plugins.config.nvim_treesitter")
    end,
    run = function()
        local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
        ts_update()
    end,
    summary = "Syntax Highlighting"
}

local telescope = {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    requires = {
        { 'nvim-lua/plenary.nvim' }
    },
    config = function()
        require("plugins.config.telescope")
    end,
    summary = "Utility"
}

local spectre = {
    'windwp/nvim-spectre',
    config = function()
        require("plugins.config.nvim_spectre")
    end,
    summary = "Search and Replace"
}

local toggleterm = {
    "akinsho/toggleterm.nvim",
    tag = '*',
    config = function()
        require("plugins.config.toggleterm")
    end,
    summary = "Terminal integration"
}

local githubnvimtheme = {
    'projekt0n/github-nvim-theme',
}

local nvimcmp = {
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
    end,
    summary = "Code Completion"
}

local windsurf = {
    'Exafunction/windsurf.vim',
    config = function()
        require("plugins.config.windsurf")
    end,
    summary = "AI editor assistant"
}

local nvimmasonlspconfig = {
    "williamboman/mason-lspconfig.nvim",
    after = "mason.nvim",
    config = function()
        -- Nothing ToDo
    end,
    summary = "LSP Server Installer"
}

local nvimlspconfig = {
    "neovim/nvim-lspconfig",
    after = "mason-lspconfig.nvim",
    config = function()
        require("plugins.config.nvim_lsp")
    end,
    summary = "LSP Configuration"
}

local VimVisualMulti = {
    'mg979/vim-visual-multi'
}

local cmaketools = {
    'Civitasv/cmake-tools.nvim',
    config = function()
        require("plugins.config.cmake_tools")
    end,
    summary = "CMake tools Integration"
}

local dressing = {
    'stevearc/dressing.nvim',
    config = function()
        require("plugins.config.dressing")
    end,
    summary = "Neovim UI components, like input boxes"
}

local luasnip = {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!:).
    run = "make install_jsregexp",
    config = function()
        require("plugins.config.luasnip")
    end,
    summary = "The code snippet manager"
}

local lualine = {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true },
    config = function()
        require("plugins.config.lualine")
    end,
    summary = "Statusline, Bottomline"
}

local dashboard = {
    'nvimdev/dashboard-nvim',
    config = function()
        require('plugins.config.dashboard')
    end,
    requires = { 'nvim-tree/nvim-web-devicons' },
    event = 'VimEnter',
    summary = "Dashboard"
}

local tokyonightTheme = {
    'folke/tokyonight.nvim',
    summary = "Tokyo Night Theme"
}

local kanagawaTheme = {
    'rebelot/kanagawa.nvim',
    summary = "Kanagawa Theme"
}

local rendermarkdown = {
    'MeanderingProgrammer/render-markdown.nvim',
    after = { 'nvim-treesitter' },
    requires = { 'echasnovski/mini.nvim', opt = true }, -- if you use the mini.nvim suite
    config = function()
        require('render-markdown').setup({})
    end,
    summary = "Render Markdown for Preview"
}

local leap = {
    'ggandor/leap.nvim',
    config = function()
        require('plugins.config.leap')
    end,
    summary = "Leap Motion, Jump to anywhere"
}

local trouble = {
    'folke/trouble.nvim',
    requires = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('plugins.config.trouble')
    end,
    summary = "Trouble"
}

local catppuccinTheme = {
    'catppuccin/nvim',
    as = 'catppuccin',
}

local confrom = {
    'stevearc/conform.nvim',
    config = function()
        require('plugins.config.conform')
    end,
    summary = "Code Formatter"
}

local dropbar = {
    'Bekaboo/dropbar.nvim',
    requires = {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'
    },
    config = function()
        -- local dropbar_api = require('dropbar.api')
        -- vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
        -- vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
        -- vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })
    end,
    summary = "Dropbar"
}

local miniicon = {
    "echasnovski/mini.icons",
    version = false,
    config = function()
        require("mini.icons").setup()
    end,
}

return {
    mason,
    nvimtree,
    nvimwebdevicons,
    gitsigns,
    nvimtreesitter,
    telescope,
    spectre,
    toggleterm,
    githubnvimtheme,
    nvimcmp,
    windsurf,
    nvimmasonlspconfig,
    nvimlspconfig,
    VimVisualMulti,
    cmaketools,
    dressing,
    luasnip,
    lualine,
    dashboard,
    tokyonightTheme,
    rendermarkdown,
    leap,
    trouble,
    catppuccinTheme,
    kanagawaTheme,
    confrom,
    dropbar,
    miniicon
}
