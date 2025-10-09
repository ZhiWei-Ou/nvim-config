-- keymaps.lua

vim.g.mapleader = '.'
vim.g.maplocalleader = "\\"

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

-- luasnip
local ls = require("luasnip")
vim.keymap.set({ "i", "s" }, "<C-l>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end, { silent = true })

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

vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
    desc = "Toggle Spectre"
})
vim.keymap.set('n', '<leader>F', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
    desc = "Search current word"
})
vim.keymap.set('v', '<leader>F', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
    desc = "Search current word"
})
vim.keymap.set('n', '<leader>f', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
    desc = "Search on current file"
})
vim.keymap.set('v', '<leader>f', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
    desc = "Search on current file"
})
