---@brief telescope.nvim setup
---@refer https://github.com/nvim-telescope/telescope.nvim
---@note 需要下载ripgrep ```bash $ brew install ripgrep ```

local function grep_visual_selection()
  local selection = vim.fn.getregion(vim.fn.getpos('v'), vim.fn.getpos('.'), { type = vim.fn.mode() })
  require('telescope.builtin').grep_string({ search = table.concat(selection, '\n') })
end

return {
  'nvim-telescope/telescope.nvim',
  version = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  summary = "Find, Filter, Preview, Pick. All lua, all the time.",
  enabled = true,

  keys = {
    {
      '<C-p>',
      function()
        require('telescope.builtin').find_files()
      end,
      mode = { 'n' },
      desc = 'find files in current workspace'
    },
    {
      '<C-F>',
      function()
        require('telescope.builtin').live_grep()
      end,
      mode = { 'n' },
      desc = 'live grep in current workspace'
    },
    {
      '<C-F>',
      grep_visual_selection,
      mode = { 'v' },
      desc = 'grep visual selection in current workspace'
    },
    {
      '<C-K><C-p>',
      function()
        require('telescope.builtin').builtin({ include_extensions = true })
      end,
      mode = { 'n' },
      desc = 'show all telescope built-in pickers'
    }
  },
  opts = {
    defaults = {
      prompt_prefix = "   ",
      selection_caret = " ",
      entry_prefix = "  ",
      multi_icon = " ",
      wrap_results = false,
      sorting_strategy = 'ascending',
      path_display = { 'smart' },
      dynamic_preview_title = true,
      results_title = false,
      layout_strategy = 'flex',
      layout_config = {
        prompt_position = 'top',
        width = 0.9,
        height = 0.85,
        horizontal = {
          preview_width = 0.55,
        },
        vertical = {
          preview_height = 0.5,
        },
      },
      borderchars = {
        prompt = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
        results = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
        preview = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
      },

      -- issue: https://github.com/nvim-telescope/telescope.nvim/issues/3487
      preview = {
        treesitter = false,
      },
    },
    pickers = {
      find_files = {
        find_command = { 'fd', '--type', 'f', '--strip-cwd-prefix' },
        theme = "dropdown",
        previewer = false,
        prompt_title = ' Find Files ',
        layout_config = {
          width = 0.65,
          height = 0.6,
        },
      },
      builtin = {
        theme = "dropdown",
        previewer = false,
        prompt_title = ' Telescope ',
        layout_config = {
          width = 0.65,
          height = 0.6,
        },
      },
      live_grep = {
        prompt_title = ' Live Grep ',
      },
      grep_string = {
        prompt_title = ' Grep Selection ',
      },
      colorscheme = {
        enable_preview = true,
      },
      commands = {
        show_buf_command = false
      }
    },
  },
}
