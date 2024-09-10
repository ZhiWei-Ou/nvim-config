-- keymaps.lua

vim.g.mapleader = '.'

vim.api.nvim_set_keymap('n', '<Space>', ':', { noremap = true, silent = false })

vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<C-\\>', ':vsplit<CR>', { noremap = true, silent = true })

-- vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h<CR>', { noremap = true, silent = true })
--
-- vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l<CR>', { noremap = true, silent = true })

-- Insert 模式下，Ctrl+s 保存文件
vim.api.nvim_set_keymap('i', '<C-s>', '<Esc>:w<CR>a', { noremap = true, silent = true })

-- Visual 模式下，Ctrl+c 复制选中的文本到系统剪贴板
vim.api.nvim_set_keymap('v', '<C-c>', '"+y', { noremap = true, silent = true })

-- vim.api.nvim_set_keymap('n', '<leader>p', ':BufferLinePick<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k><C-w>', ':BufferLineCloseOthers<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<C-w>', ':bd<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>1', ':BufferLineGoToBuffer 1<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>2', ':BufferLineGoToBuffer 2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>3', ':BufferLineGoToBuffer 3<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>4', ':BufferLineGoToBuffer 4<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>5', ':BufferLineGoToBuffer 5<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>6', ':BufferLineGoToBuffer 6<CR>', { noremap = true, silent = true })

-- luasnip
local ls = require("luasnip")
vim.keymap.set({"i", "s"}, "<C-l>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})
-- buffer line keymaps
-- nnoremap <silent><leader>1 <Cmd>BufferLineGoToBuffer 1<CR>
-- nnoremap <silent><leader>2 <Cmd>BufferLineGoToBuffer 2<CR>
-- nnoremap <silent><leader>3 <Cmd>BufferLineGoToBuffer 3<CR>
-- nnoremap <silent><leader>4 <Cmd>BufferLineGoToBuffer 4<CR>
-- nnoremap <silent><leader>5 <Cmd>BufferLineGoToBuffer 5<CR>
-- nnoremap <silent><leader>6 <Cmd>BufferLineGoToBuffer 6<CR>
-- nnoremap <silent><leader>7 <Cmd>BufferLineGoToBuffer 7<CR>
-- nnoremap <silent><leader>8 <Cmd>BufferLineGoToBuffer 8<CR>
-- nnoremap <silent><leader>9 <Cmd>BufferLineGoToBuffer 9<CR>
-- nnoremap <silent><leader>$ <Cmd>BufferLineGoToBuffer -1<CR>
--
