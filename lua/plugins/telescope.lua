---@brief telescope.nvim setup
---@refer https://github.com/nvim-telescope/telescope.nvim
---@note 需要下载ripgrep ```bash $ brew install ripgrep ```

return {
  'nvim-telescope/telescope.nvim',
  version = '0.1.8',
  dependencies = { { 'nvim-lua/plenary.nvim', opt = true } },
  summary = "Find, Filter, Preview, Pick. All lua, all the time.",

  keys = {
    {
      '<C-p>',
      '<cmd>lua require("telescope.builtin").find_files({find_command={"rg", "--files", "-i"}, theme="dropdown", previewer=false, layout_config={width=0.5, height=0.5}})<CR>',
      mode = { 'n' },
      desc = 'find files in current working directory'
    },
    {
      '<C-F>',
      '<cmd>lua require("telescope.builtin").live_grep()<CR>',
      mode = { 'n' },
      desc = 'live grep in current working directory'
    },
    {
      '<C-F>',
      '<cmd>lua require("telescope.builtin").grep_string()<CR>',
      mode = { 'v' },
      desc = 'live grep in current working directory'
    },
    {
      '<C-K><C-p>',
      '<cmd>lua require("telescope.builtin").builtin{include_extensions = true}<CR>',
      mode = { 'n' },
      desc = 'show all telescope built-in pickers'
    }
  },
  opts = {
    defaults = {
      mappings = {
        i = {
          -- ["<C-p>"] = require('telescope.builtin').find_files,
          -- ["<C-F>"] = require('telescope.builtin').live_grep,
        },
        n = {
          -- ["<C-p>"] = require('telescope.builtin').find_files,
          -- ["<C-F>"] = require('telescope.builtin').live_grep,
        },
      },
      find_command = { 'fd', '--type', 'f', '--strip-cwd-prefix' },
      file_ignore_patterns = { "node_modules", ".git/", "build/", "out/" },
      -- prompt_prefix = "🔍 ",
      selection_caret = "➤ ",
      multi_icon = " ",
      wrap_results = false,
      results_title = "Results",

      -- issue: https://github.com/nvim-telescope/telescope.nvim/issues/3487
      preview = {
        treesitter = false,
      },
    },
    pickers = {
      builtin = {
        theme = "dropdown",
        previewer = false,
        layout_config = {
          width = 0.5,
          height = 0.5,
        },
      },
      colorscheme = {
        enable_preview = true,
      },
      commands = {
        show_buf_command = false
      }
    },
    extensions = {
    }
  },
  config = function(_, opts)
    require('telescope').setup(opts)
  end,
}
