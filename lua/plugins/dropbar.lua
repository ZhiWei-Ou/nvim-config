---@brief dropbar plugin
---@refer https://github.com/Bekaboo/dropbar.nvim

return {
  'Bekaboo/dropbar.nvim',
  dependencies = {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make'
  },
}
