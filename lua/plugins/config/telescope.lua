--
-- @note: 需要下载ripgrep ```bash $ brew install ripgrep ```
--
--

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
    prompt_prefix = "🔍 ",
    selection_caret = "➤ ",
    multi_icon = " ",
    wrap_results = false,
    results_title = "Results",
  },
  pickers = {
    builtin = {
      theme = "dropdown",
      previewer = false,
      layout_config = {
        width = 0.8,
        height = 0.5,
      },
    },
    colorscheme = {
      enable_preview = true,
      previewer = true,
    },
  },
  extensions = {
    emoji = {
      action = function(emoji)
        -- argument emoji is a table.
        -- {name="", value="", cagegory="", description=""}

        vim.fn.setreg("*", emoji.value)
        print([[Press p or "*p to paste this emoji]] .. emoji.value)

        -- insert emoji when picked
        vim.api.nvim_put({ emoji.value }, 'c', false, true)
      end,
    }
  }
}

-- 获取 Visual 模式选中文本
local function get_visual_selection()
  local _, ls_row, ls_col = unpack(vim.fn.getpos("'<"))
  local _, le_row, le_col = unpack(vim.fn.getpos("'>"))
  local lines = vim.fn.getline(ls_row, le_row)
  if #lines == 0 then return "" end

  lines[#lines] = string.sub(lines[#lines], 1, le_col)
  lines[1] = string.sub(lines[1], ls_col)
  return table.concat(lines, '\n')
end

-- grep 选中文本
function _G.live_grep_visual()
  local text = get_visual_selection()
  require('telescope.builtin').live_grep({ default_text = text })
end

-- 模糊搜索
-- 搜索文件 {find_command={"fd", "--type", "f", "--strip-cwd-prefix"}}
vim.api.nvim_set_keymap('n', '<C-p>',
  '<cmd>lua require("telescope.builtin").find_files({find_command={"rg", "--files", "-i"}})<CR>',
  { noremap = true, silent = true })
-- 搜索匹配字符串
vim.api.nvim_set_keymap('n', '<C-F>', '<cmd>lua require("telescope.builtin").live_grep()<CR>',
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-F>', ':<C-U>lua live_grep_visual()<CR>',
  { noremap = true, silent = true })
-- 工具集
vim.api.nvim_set_keymap('n', '<C-K><C-p>', '<cmd>lua require("telescope.builtin").builtin{include_extensions = true}<CR>',
  { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<C-K><C-p>', '<cmd>Telescope<CR>', { noremap = true, silent = true })
