---@brief render-markdown.nvim setup
---@refer https://github.com/MeanderingProgrammer/render-markdown.nvim

return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'echasnovski/mini.nvim', 'nvim-treesitter' },
  opts = {},
  config = function(_, opts)
    require('render-markdown').setup(opts)
  end,
}
