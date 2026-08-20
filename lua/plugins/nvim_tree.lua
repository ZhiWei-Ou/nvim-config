---@brief nvim-tree setup
---@refer https://github.com/nvim-tree/nvim-tree.lua

return {
  'nvim-tree/nvim-tree.lua',
  enabled = true,
  summary = 'File Explorer',
  cmd = { 'NvimTreeOpen', 'NvimTreeClose', 'NvimTreeToggle', 'NvimTreeFocus' },
  keys = {
    {
      '<C-l>',
      '<cmd>NvimTreeToggle<CR>',
      mode = 'n',
      desc = 'Toggle nvim-tree (file explorer)',
    },
  },
  opts = {
    hijack_cursor = true,
    renderer = {
      special_files = {},
      symlink_destination = false,
      highlight_git = 'name',
      indent_markers = {
        enable = true,
      },
      icons = {
        show = {
          git = false,
        },
        glyphs = {
          modified = '[+]',
          git = {
            ignored = '',
          },
        },
      },
    },
    update_focused_file = {
      enable = true,
    },
    modified = {
      enable = true,
    },
    filesystem_watchers = {
      ignore_dirs = {
        '/.ccls-cache',
        '/build',
        '/node_modules',
        '/target',
      },
    },
  },
  config = function(_, opts)
    require('nvim-tree').setup(opts)

    local api = require 'nvim-tree.api'
    api.events.subscribe(api.events.Event.Ready, function()
      require('core.project_cache').restore_nvim_tree_filters()
    end)
  end,
}
