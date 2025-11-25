--- @brief
--- 该函数封装了 `vim.api.nvim_set_keymap()`，用于在指定模式下将某个按键
--- 映射到指定的命令或键序列。通常用于配置快捷键。
---
--- @param mode string
---     键映射所在的模式，可取：
---       - 'n' : Normal
---       - 'i' : Insert
---       - 'v' : Visual
---       - 'x' : VisualSelect
---       - 's' : Select
---       - 'o' : Operator-pending
---       - 't' : Terminal
---     也可组合，例如 'nv' 表示 Normal + Visual。
---
--- @param lhs string
---     触发映射的按键（Left-hand side）。例如：
---       - '<Space>'
---       - '<C-s>'
---       - '<leader>f'
---       - 'jk'
---
--- @param rhs string
---     映射后的操作（Right-hand side）。可以是命令（如 ':w<CR>'）、
---     按键序列（如 'gg=G'）、Lua 调用（':lua print("hi")<CR>'）等。
---
--- @param opts table
---     映射选项表，常见字段包括：
---       - noremap : boolean  是否禁止递归映射（推荐 true）
---       - silent  : boolean  是否禁止回显命令
---       - expr    : boolean  将 rhs 视为表达式求值
---       - nowait  : boolean  不等待进一步按键
---       - unique  : boolean  若已存在映射则报错
---       - desc    : string   描述（Neovim 0.7+ 支持，但 set_keymap 不使用此字段）
---
--- @return nil
local function K(mode, lhs, rhs, opts)
  -- vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts)
end

--- @brief
K('n', '<Space>', ':',
  { noremap = true, silent = false, desc = 'Enter command mode' })

--- @brief
K('n', '<C-s>', ':w<CR>',
  { noremap = true, silent = true, nowait = true, desc = 'Save file in normal mode' })

--- @brief
K('i', '<C-s>', '<Esc>:w<CR>a',
  { noremap = true, silent = true, nowait = true, desc = 'Save file in insert mode' })

--- @brief
K('n', '<C-\\>', '<C-w>v',
  { noremap = true, silent = true, nowait = true, desc = 'Vertical split' })

--- @brief
K('v', '<C-c>', '+y',
  { noremap = true, silent = true, nowait = true, desc = 'Copy selected text to system clipboard' })
