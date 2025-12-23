----- lua/plugins/dashboard.lua
---@brief dashboard plugin
---@date 2025-12-17
---@refer https://github.com/nvimdev/dashboard-nvim

return {
  'nvimdev/dashboard-nvim',
  dependencies = { { 'nvim-tree/nvim-web-devicons', opt = true }, { 'echasnovski/mini.icons' } },
  lazy = false,
  event = 'VimEnter',

  opts = {
    theme = 'hyper',
    shortcut_type = 'letter', -- letter or number
    change_to_vcs_root = true,
    packages = {
      enable = true, -- show how many plugins neovim loaded
    },
    config = {
      header = require('ui').get_logo(),
      project = {
        enable = false,
        limit = 8,
        icon = nil, --MiniIcons.get('directory', 'nvim'),
        label = ' Recently Project',
        action = 'Telescope find_files cwd='
      },
      mru = { enable = false, },
      week_header = {
        enable = false,
      },
      shortcut = {
        {
          icon = nil, --MiniIcons.get('directory', 'build'),
          desc = ' Update',
          group = 'Label',
          action = 'Lazy update',
          key = '<C-u>'
        },
        {
          icon = nil, --MiniIcons.get('default', 'file'),
          desc = ' Files',
          group = 'Label',
          action = 'Telescope find_files',
          key = '<C-f>',
        },
        {
          icon = nil, --MiniIcons.get('lsp', 'color'),
          desc = ' Colorscheme',
          group = 'Label',
          action = 'Telescope colorscheme',
          key = '<C-c>',
        },
        {
          icon = nil, --MiniIcons.get('filetype', 'help'),
          desc = ' Commands',
          group = 'Label',
          action = 'Telescope',
          key = '?',
        }
      },
    },
  },
  config = function(_, opts)
    opts.config.project.icon = require('mini.icons').get('directory', 'nvim')
    opts.config.shortcut[1].icon = require('mini.icons').get('directory', 'build')
    opts.config.shortcut[2].icon = require('mini.icons').get('default', 'file')
    opts.config.shortcut[3].icon = require('mini.icons').get('lsp', 'color')
    opts.config.shortcut[4].icon = require('mini.icons').get('filetype', 'help')
    require('dashboard').setup(opts)
  end,
}
