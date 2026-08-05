---@brief nvim-tree setup
---@refer https://github.com/nvim-tree/nvim-tree.lua

return {
  'nvim-tree/nvim-tree.lua',
  enabled = true,
  summary = 'File Explorer',
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
}
