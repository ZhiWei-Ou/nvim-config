---@brief nvim-tree setup
---@refer https://github.com/nvim-tree/nvim-tree.lua

local function set_nvim_tree_highlights()
  -- 1. 基础文件类型：颜色更饱满，区分度更高
  -- 可执行文件：改成洋红色/玫红，在一堆文件中非常显眼
  vim.api.nvim_set_hl(0, "NvimTreeExecFile", { fg = "#bb9af7", bold = true })
  -- 特殊文件：深紫色+下划线
  vim.api.nvim_set_hl(0, "NvimTreeSpecialFile", { fg = "#9d7cd8", underline = true, bold = true })
  -- 软链接：青色斜体，代表“指向别处”
  vim.api.nvim_set_hl(0, "NvimTreeSymlink", { fg = "#7dcfff", italic = true })

  -- 图片文件：用淡黄色，与文字区分
  vim.api.nvim_set_hl(0, "NvimTreeImageFile", { fg = "#e0af68" })

  -- 2. 文件夹：使用深蓝色系，作为背景色很稳重
  -- 普通文件夹：深天蓝
  vim.api.nvim_set_hl(0, "NvimTreeFolderName", { fg = "#82aaff", bold = true })
  -- 打开的文件夹：更亮一点的蓝色，或者白色高亮，表示“当前聚焦”
  vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { fg = "#c0caf5", bold = true })
  -- 空文件夹：深灰色，表示“里面没东西，别看了”
  vim.api.nvim_set_hl(0, "NvimTreeEmptyFolderName", { fg = "#565f89", italic = true })

  -- 3. Git 状态：高对比度警告色
  -- Dirty (修改过)：明亮的琥珀色/金色，表示“注意这里”
  vim.api.nvim_set_hl(0, "NvimTreeGitDirty", { fg = "#ffc777", bold = true })
  -- Staged (暂存)：纯正的绿色
  vim.api.nvim_set_hl(0, "NvimTreeGitStaged", { fg = "#9ece6a" })
  -- Merge (合并中)：紫色
  vim.api.nvim_set_hl(0, "NvimTreeGitMerge", { fg = "#bb9af7" })
  -- Renamed (重命名)：青色
  vim.api.nvim_set_hl(0, "NvimTreeGitRenamed", { fg = "#7dcfff" })
  -- New (新增)：孔雀绿/青绿色，比普通绿色更高级，区别于 Staged
  vim.api.nvim_set_hl(0, "NvimTreeGitNew", { fg = "#4fd6be" })
  -- Deleted (删除)：深红色
  vim.api.nvim_set_hl(0, "NvimTreeGitDeleted", { fg = "#f7768e" })
  -- Ignored (忽略)：深灰色
  vim.api.nvim_set_hl(0, "NvimTreeGitIgnored", { fg = "#565f89", italic = true })

  -- 4. 分割线：最关键的修改！
  -- 不要用 PmenuMatch（太亮），要用深色。
  -- 这里设置成深蓝灰色，让它存在但不可见，不抢眼。
  vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { fg = "#3b4261", bold = true })
  -- 如果想要分割线完全消失，可以用下面这行：
  -- vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { fg = "#1f2335", bg = "#1f2335" })
end

return {
  "nvim-tree/nvim-tree.lua",
  summary = "File Explorer",
  keys = {
    {
      '<C-l>',
      '<cmd>NvimTreeToggle<CR>',
      mode = { 'n' },
      desc = 'Toggle nvim-tree(File Explorer)'
    }
  },
  opts = {
    -- BEGIN_DEFAULT_OPTS
    on_attach = "default",
    hijack_cursor = true,
    auto_reload_on_write = true,
    disable_netrw = false,
    hijack_netrw = true,
    hijack_unnamed_buffer_when_opening = false,
    root_dirs = {},
    prefer_startup_root = false,
    sync_root_with_cwd = false,
    reload_on_bufenter = false,
    respect_buf_cwd = false,
    select_prompts = false,
    sort = {
      sorter = "name",
      folders_first = true,
      files_first = false,
    },
    view = {
      centralize_selection = false,
      cursorline = true,
      cursorlineopt = "both",
      debounce_delay = 15,
      side = "left",
      preserve_window_proportions = false,
      number = false,
      relativenumber = false,
      signcolumn = "yes",
      width = 30,
      float = {
        enable = false,
        quit_on_focus_loss = true,
        open_win_config = {
          relative = "editor",
          border = "rounded",
          width = 30,
          height = 30,
          row = 1,
          col = 1,
        },
      },
    },
    renderer = {
      add_trailing = false,
      group_empty = false,
      full_name = false,
      root_folder_label = ":~:s?$?/..?",
      indent_width = 2,
      special_files = { --[[  "Cargo.toml", "Makefile", "README.md", "readme.md"  ]] },
      hidden_display = "none",
      symlink_destination = false,
      decorators = { "Git", "Open", "Hidden", "Modified", "Bookmark", "Diagnostics", "Copied", "Cut", },
      highlight_git = true, -- "none",
      highlight_diagnostics = "none",
      highlight_opened_files = "none",
      highlight_modified = "none",
      highlight_hidden = "none",
      highlight_bookmarks = "none",
      highlight_clipboard = "name",
      indent_markers = {
        enable = true,
        inline_arrows = true,
        icons = {
          corner = "└",
          edge = "│",
          item = "│",
          bottom = "─",
          none = " ",
        },
      },
      icons = {
        web_devicons = {
          file = {
            enable = true,
            color = true,
          },
          folder = {
            enable = false,
            color = true,
          },
        },
        git_placement = "before",
        modified_placement = "after",
        hidden_placement = "after",
        diagnostics_placement = "signcolumn",
        bookmarks_placement = "signcolumn",
        padding = {
          icon = " ",
          folder_arrow = " ",
        },
        symlink_arrow = " ➛ ",
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = false,
          modified = true,
          hidden = false,
          diagnostics = true,
          bookmarks = true,
        },
        glyphs = {
          default = "",
          symlink = "",
          bookmark = "󰆤",
          -- modified = "●",
          modified = "[+]",
          hidden = "󰜌",
          folder = {
            arrow_closed = "",
            arrow_open = "",
            default = "",
            open = "",
            empty = "",
            empty_open = "",
            symlink = "",
            symlink_open = "",
          },
          git = {
            unstaged = "✗",
            staged = "✓",
            unmerged = "",
            renamed = "➜",
            untracked = "★",
            deleted = "",
            ignored = "",
            -- ignored = "◌",
          },
        },
      },
    },
    hijack_directories = {
      enable = true,
      auto_open = true,
    },
    update_focused_file = {
      enable = true,
      update_root = {
        enable = false,
        ignore_list = {},
      },
      exclude = false,
    },
    system_open = {
      cmd = "",
      args = {},
    },
    git = {
      enable = true,
      show_on_dirs = true,
      show_on_open_dirs = true,
      disable_for_dirs = {},
      timeout = 400,
      cygwin_support = false,
    },
    diagnostics = {
      enable = false,
      show_on_dirs = false,
      show_on_open_dirs = true,
      debounce_delay = 500,
      severity = {
        min = vim.diagnostic.severity.HINT,
        max = vim.diagnostic.severity.ERROR,
      },
      icons = {
        hint = "",
        info = "",
        warning = "",
        error = "",
      },
      diagnostic_opts = false,
    },
    modified = {
      enable = true,
      show_on_dirs = true,
      show_on_open_dirs = true,
    },
    filters = {
      enable = true,
      git_ignored = true,
      dotfiles = false,
      git_clean = false,
      no_buffer = false,
      no_bookmark = false,
      custom = {},
      exclude = {},
    },
    live_filter = {
      prefix = "[FILTER]: ",
      always_show_folders = true,
    },
    filesystem_watchers = {
      enable = true,
      debounce_delay = 50,
      ignore_dirs = {
        "/.ccls-cache",
        "/build",
        "/node_modules",
        "/target",
      },
    },
    actions = {
      use_system_clipboard = true,
      change_dir = {
        enable = true,
        global = false,
        restrict_above_cwd = false,
      },
      expand_all = {
        max_folder_discovery = 300,
        exclude = {},
      },
      file_popup = {
        open_win_config = {
          col = 1,
          row = 1,
          relative = "cursor",
          border = "shadow",
          style = "minimal",
        },
      },
      open_file = {
        quit_on_open = false,
        eject = true,
        resize_window = true,
        relative_path = true,
        window_picker = {
          enable = true,
          picker = "default",
          chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
          exclude = {
            filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
            buftype = { "nofile", "terminal", "help" },
          },
        },
      },
      remove_file = {
        close_window = true,
      },
    },
    trash = {
      cmd = "gio trash",
    },
    tab = {
      sync = {
        open = false,
        close = false,
        ignore = {},
      },
    },
    notify = {
      threshold = vim.log.levels.INFO,
      absolute_path = true,
    },
    help = {
      sort_by = "key",
    },
    ui = {
      confirm = {
        remove = true,
        trash = true,
        default_yes = false,
      },
    },
    experimental = {
    },
    log = {
      enable = false,
      truncate = false,
      types = {
        all = false,
        config = false,
        copy_paste = false,
        dev = false,
        diagnostics = false,
        git = false,
        profile = false,
        watcher = false,
      },
    },

  },
  config = function(_, opts)
    -- file type highlight
    set_nvim_tree_highlights()

    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = set_nvim_tree_highlights,
    })

    require('nvim-tree').setup(opts)
  end,
}
