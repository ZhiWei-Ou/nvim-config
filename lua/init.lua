--[[
vim.g: global variables (g:)
vim.b: variables for the current buffer (b:)
vim.w: variables for the current window (w:)
vim.t: variables for the current tabpage (t:)
vim.v: predefined Vim variables (v:)
vim.env: environment variables defined in the editor session
]]

vim.cmd('syntax enable') -- 启用语法高亮
vim.o.hidden = true      -- 允许在有未保存的修改时切换缓冲区
vim.o.tabstop = 4        -- 设置制表符的宽度为 4 个空格
vim.o.softtabstop = 4    -- 设置在编辑模式下按退格键时的宽度为 4 个空格
vim.o.shiftwidth = 4     -- 设置每一级缩进的宽度为 4 个空格
vim.o.expandtab = true   -- 将制表符转换为空格
vim.o.smartindent = true -- 智能缩进
vim.o.autoindent = true  -- 自动缩进
vim.o.ignorecase = true  -- 搜索时忽略大小写
vim.o.smartcase = true   -- 搜索时根据输入的大小写开启或关闭忽略大小写
vim.o.incsearch = true   -- 实时搜索
vim.o.hlsearch = true    -- 高亮显示搜索结果
vim.o.showmode = false   -- 隐藏模式显示
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.lsp.foldexpr()"
vim.o.foldlevel = 99
-- a: all mode, n: normal mode, v: visual mode, i: insert mode, c: command mode, h: help mode
vim.o.mouse = 'a'           -- 启用鼠标支持
vim.o.number = true         -- 显示行号
vim.o.relativenumber = true -- 显示相对行号
vim.o.cursorline = true     -- 高亮当前行
vim.o.wrap = false          -- 禁用自动换行
vim.o.showmatch = true      -- 显示匹配的括号

vim.g.mapleader = '.'
vim.g.maplocalleader = "\\"
vim.g.default_theme = 'default'

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

---@section OSC52_Clipboard
---@brief use neovim built-in OSC52 clipboard for ssh
if vim.env.SSH_TTY then
  vim.g.clipboard = {
    name = 'OSC 52 (SSH Only)',
    copy = {
      ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
      ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
    },
    paste = {
      ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
      ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
    },
  }
end
vim.opt.clipboard = "unnamedplus"
--- @endsection

require 'core'
require 'lazy_mngr'
require 'theme_mngr'
