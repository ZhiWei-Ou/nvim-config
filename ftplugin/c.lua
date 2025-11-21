-- vim.cmd('setlocal commentstring=//%s')

vim.treesitter.start(nil, 'c')
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
