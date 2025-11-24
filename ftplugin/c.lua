vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"


local ok, _ = pcall(require, 'conform')
if ok then
  if vim.fs.find({ '.clang-format' }, { upward = true }) then
    vim.b.conform_enable = true
  else
    vim.b.conform_enable = false
  end
end
