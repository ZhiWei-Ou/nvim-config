--- @brief: telescope.nvim setup
--- @refer: https://github.com/nvim-telescope/telescope.nvim
--- @note: 需要下载ripgrep ```bash $ brew install ripgrep ```

return {
  'nvim-telescope/telescope.nvim',
  version = '0.1.8',
  dependencies = { { 'nvim-lua/plenary.nvim', opt = true } },
  summary = "Find, Filter, Preview, Pick. All lua, all the time.",
  config = function()
    local builtin = require('telescope.builtin')
    local themes = require('telescope.themes')

    require('telescope').setup {
      defaults = {
        mappings = {
          i = {
            -- ["<C-p>"] = require('telescope.builtin').find_files,       -- 工作区搜索文件
            -- ["<C-F>"] = require('telescope.builtin').live_grep,        -- 工作区匹配字符串
          },
          n = {
            -- ["<C-p>"] = require('telescope.builtin').find_files,       -- 工作区搜索文件
            -- ["<C-F>"] = require('telescope.builtin').live_grep,        -- 工作区匹配字符串
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
    }

    -- 模糊搜索
    -- 搜索文件 {find_command={"fd", "--type", "f", "--strip-cwd-prefix"}}
    vim.api.nvim_set_keymap('n', '<C-p>',
      '<cmd>lua require("telescope.builtin").find_files({find_command={"rg", "--files", "-i"}, theme="dropdown", previewer=false, layout_config={width=0.5, height=0.5}})<CR>',
      { noremap = true, silent = true })
    -- 搜索匹配字符串
    vim.api.nvim_set_keymap('n', '<C-F>', '<cmd>lua require("telescope.builtin").live_grep()<CR>',
      { noremap = true, silent = true })
    vim.api.nvim_set_keymap('v', '<C-F>', '<cmd>lua require("telescope.builtin").grep_string()<CR>',
      { noremap = true, silent = true })
    -- 工具集
    vim.api.nvim_set_keymap('n', '<C-K><C-p>',
      '<cmd>lua require("telescope.builtin").builtin{include_extensions = true}<CR>',
      { noremap = true, silent = true })
    -- vim.api.nvim_set_keymap('n', '<C-K><C-p>', '<cmd>Telescope<CR>', { noremap = true, silent = true })
  end,
}
