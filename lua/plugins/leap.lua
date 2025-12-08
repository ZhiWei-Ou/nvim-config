---@brief leap motion plugin
---@refer https://github.com/ggandor/leap.nvim

-- vim.keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap)')
-- vim.keymap.set('n',             'S', '<Plug>(leap-from-window)')

return {
  'ggandor/leap.nvim',
  keys = {
    {
      's',
      '<Plug>(leap)',
      mode = { 'n', 'x', 'o' },
    },
    {
      'S',
      '<Plug>(leap-from-window)',
      mode = 'n',
    }
  }
}
