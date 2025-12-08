---@brief render-markdown.nvim setup
---@refer https://github.com/MeanderingProgrammer/render-markdown.nvim

return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'echasnovski/mini.nvim', 'nvim-treesitter' },
  config = function()
    require('render-markdown').setup({})
  end,
}
