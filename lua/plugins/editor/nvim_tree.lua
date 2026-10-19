---@brief nvim-tree setup
---@refer https://github.com/nvim-tree/nvim-tree.lua

local function on_attach(bufnr)
  local api = require 'nvim-tree.api'
  api.map.on_attach.default(bufnr)

  local info_win
  vim.keymap.set('n', '<C-k>', function()
    if info_win and vim.api.nvim_win_is_valid(info_win) then
      vim.api.nvim_win_close(info_win, true)
      info_win = nil
      return
    end

    local node = api.tree.get_node_under_cursor()
    if not node or not node.link_to then
      api.node.show_info_popup()
      return
    end

    local lines = {
      ' fullpath: ' .. node.absolute_path,
      ' target:   ' .. node.link_to,
    }
    local stats = node.fs_stat
    if stats then
      vim.list_extend(lines, {
        ' size:     ' .. stats.size .. ' bytes',
        ' accessed: ' .. os.date('%x %X', stats.atime.sec),
        ' modified: ' .. os.date('%x %X', stats.mtime.sec),
        ' created:  ' .. os.date('%x %X', stats.birthtime.sec),
      })
    end

    local width = 1
    for _, line in ipairs(lines) do
      width = math.max(width, vim.fn.strdisplaywidth(line))
    end
    width = math.min(width, math.max(1, math.floor(vim.o.columns * 0.9) - 2))

    local height = 0
    for _, line in ipairs(lines) do
      height = height + math.max(1, math.ceil(vim.fn.strdisplaywidth(line) / width))
    end
    height = math.min(height, math.max(1, vim.o.lines - vim.o.cmdheight - 4))

    local info_buf = vim.api.nvim_create_buf(false, true)
    vim.bo[info_buf].bufhidden = 'wipe'
    vim.api.nvim_buf_set_lines(info_buf, 0, -1, false, lines)
    local win = vim.api.nvim_open_win(info_buf, false, {
      relative = 'editor',
      row = math.max(0, math.floor((vim.o.lines - vim.o.cmdheight - height - 2) / 2)),
      col = math.max(0, math.floor((vim.o.columns - width - 2) / 2)),
      width = width,
      height = height,
      style = 'minimal',
      border = 'rounded',
      focusable = false,
      noautocmd = true,
    })
    vim.wo[win].wrap = true
    vim.wo[win].linebreak = false
    info_win = win

    local close_autocmd = vim.api.nvim_create_autocmd({ 'CursorMoved', 'BufLeave', 'BufHidden', 'InsertCharPre' }, {
      buffer = bufnr,
      callback = function()
        if vim.api.nvim_win_is_valid(win) then
          vim.api.nvim_win_close(win, true)
        end
      end,
    })
    vim.api.nvim_create_autocmd('WinClosed', {
      pattern = tostring(win),
      once = true,
      callback = function()
        vim.api.nvim_del_autocmd(close_autocmd)
        info_win = nil
      end,
    })
  end, { buffer = bufnr, desc = 'Info (including symlink target)', noremap = true, silent = true, nowait = true })
end

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
    on_attach = on_attach,
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
