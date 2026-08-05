---@brief global editor options

vim.cmd 'syntax enable'

-- Lite mode: set `NVIM_LITE=1` or `let g:lite_mode=1` before startup.
if vim.g.lite_mode == nil then
  local env_lite = vim.env.NVIM_LITE
  vim.g.lite_mode = env_lite == '1' or env_lite == 'true'
end

vim.g.mapleader = '.'
vim.g.maplocalleader = '\\'
vim.g.default_theme = 'default'
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.o.hidden = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.showmode = false
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.lsp.foldexpr()'
vim.o.foldlevel = 99
vim.o.mouse = 'a'
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.wrap = false
vim.o.showmatch = true
vim.o.termguicolors = true

-- Views can only be fully collapsed with the global statusline.
vim.o.laststatus = 0
vim.o.cmdheight = 0
