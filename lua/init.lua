--[[
vim.g: global variables (g:)
vim.b: variables for the current buffer (b:)
vim.w: variables for the current window (w:)
vim.t: variables for the current tabpage (t:)
vim.v: predefined Vim variables (v:)
vim.env: environment variables defined in the editor session
    ]]

vim.cmd('syntax enable')        -- 启用语法高亮
vim.o.hidden = true             -- 允许在有未保存的修改时切换缓冲区
vim.o.tabstop = 4               -- 设置制表符的宽度为 4 个空格
vim.o.softtabstop = 4           -- 设置在编辑模式下按退格键时的宽度为 4 个空格
vim.o.shiftwidth = 4            -- 设置每一级缩进的宽度为 4 个空格
vim.o.expandtab = true          -- 将制表符转换为空格
vim.o.smartindent = true        -- 智能缩进
vim.o.autoindent = true         -- 自动缩进
vim.o.ignorecase = true         -- 搜索时忽略大小写
vim.o.smartcase = true          -- 搜索时根据输入的大小写开启或关闭忽略大小写
vim.o.incsearch = true          -- 实时搜索
vim.o.hlsearch = true           -- 高亮显示搜索结果
vim.o.showmode = false          -- 隐藏模式显示
vim.o.mouse = 'a'               -- 启用鼠标支持 a: all mode, n: normal mode, v: visual mode, i: insert mode, c: command mode, h: help mode
vim.o.number = true             -- 显示行号
vim.o.relativenumber = true     -- 显示相对行号
vim.o.cursorline = true         -- 高亮当前行
vim.o.wrap = false              -- 禁用自动换行
vim.o.clipboard = 'unnamedplus' -- 启用系统剪贴板
vim.o.showmatch = true          -- 显示匹配的括号

vim.g.mapleader = '.'
vim.g.maplocalleader = "\\"
vim.g.default_theme = 'default'

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.lsp.foldexpr()"
vim.o.foldlevel = 99

local function keymap(mode, lhs, rhs, opts) vim.api.nvim_set_keymap(mode, lhs, rhs, opts) end
keymap('n', '<Space>', ':', { noremap = true, silent = false, desc = 'Enter command mode' })
keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true, desc = 'Save file in normal mode' })
keymap('i', '<C-s>', '<Esc>:w<CR>a', { noremap = true, silent = true, desc = 'Save file in insert mode' })
keymap('n', '<C-\\>', '<C-w>v', { noremap = true, silent = true, desc = 'Vertical split' })
keymap('v', '<C-c>', '+y', { noremap = true, silent = true, desc = 'Copy selected text to system clipboard' })

require('bootstrap').startup()
require('theme').setup()
