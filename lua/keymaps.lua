-- keymaps.lua

vim.g.mapleader = '.'

vim.api.nvim_set_keymap('n',
                        '<Space>',
                        ':',
                        {
                            noremap = true,
                            silent = false,
                            desc = 'Enter command mode'
                        })

vim.api.nvim_set_keymap('n',
                        '<C-s>',
                        ':w<CR>',
                        {
                            noremap = true,
                            silent = true,
                            desc = '[Normal]Save file'
                        })
vim.api.nvim_set_keymap('i',
                        '<C-s>',
                        '<Esc>:w<CR>a',
                        {
                            noremap = true,
                            silent = true,
                            desc = '[Insert]Save file'
                        })

vim.api.nvim_set_keymap('n',
                        '<C-\\>',
                        ':vsplit<CR>',
                        {
                            noremap = true,
                            silent = true,
                            desc = 'Vertical split'
                        })

vim.api.nvim_set_keymap('v',
                        '<C-c>',
                        '"+y',
                        {
                            noremap = true,
                            silent = true,
                            desc = 'Copy selected text to system clipboard'
                                    -- Visual 模式下，Ctrl+c 复制选中的文本到系统剪贴板
                        })

vim.api.nvim_set_keymap('n',
                        '<C-k><C-w>',
                        ':BufferLineCloseOthers<CR>',
                        {
                            noremap = true,
                            silent = true,
                            desc = 'Close all buffer(editor)'
                        })

-- Switch to buffer
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

-- LSP
vim.api.nvim_set_keymap('n',
                        'gd',
                        '<cmd>lua vim.lsp.buf.definition()<CR>',
                        {
                            noremap = true,
                            silent = true,
                            desc = 'Show symbol information'
                        })


vim.api.nvim_set_keymap('i',
                        'gh',
                        '<cmd>lua vim.lsp.buf.signature_help()<CR>',
                        {
                            noremap = true,
                            silent = true,
                            desc = 'Signature help'
                        })



vim.api.nvim_set_keymap('n',
                        'gh',
                        '<cmd>lua vim.lsp.buf.hover()<CR>',
                        {
                            noremap = true,
                            silent = true,
                            desc = 'Hover symbol information'
                        })

vim.api.nvim_set_keymap('n',
                        'gr',
                        '<cmd>lua require("telescope.builtin").lsp_references()<CR>',
                        {
                            noremap = true,
                            silent = true,
                            desc = 'Show symbol references using telescope'
                        })


vim.api.nvim_set_keymap('n',
                        'gt',
                        '<cmd>lua vim.lsp.buf.type_definition()<CR>',
                        {
                            noremap = true,
                            silent = true,
                            desc = 'Show symbol type definition'
                        })


-- Outline
vim.api.nvim_set_keymap('n',
                        '<C-]>',
                        '<cmd>Trouble symbols toggle focus=false<CR>',
                        {
                            noremap = true,
                            silent = true,
                            desc = 'Toggle Outline'
                        })

-- Diagnostic
vim.api.nvim_set_keymap('n',
                        '<leader>dd',
                        '<cmd>Trouble diagnostics toggle focus=false<CR>',
                        {
                            noremap = true,
                            silent = true,
                            desc = 'Toggle Diagnostics'
                        })

-- File Explorer
vim.api.nvim_set_keymap('n',
                        '<C-l>',
                        '<cmd>NvimTreeToggle<CR>',
                        {
                            noremap = true,
                            silent = true,
                            desc = 'Toggle File Explorer'
                        })
