---@brief nvim-spectre setup
---@refer https://github.com/nvim-pack/nvim-spectre

return {
  'windwp/nvim-spectre',
  dependencies = { 'nvim-lua/plenary.nvim' },
  enabled = true,
  keys = {
    {
      '<leader>S',
      '<cmd>lua require("spectre").toggle()<CR>',
      mode = 'n',
      desc = 'Toggle Spectre',
    },
    {
      '<leader>F',
      '<cmd>lua require("spectre").open_visual({ select_word = true })<CR>',
      mode = 'n',
      desc = 'Search current word',
    },
    {
      '<leader>F',
      '<Esc><cmd>lua require("spectre").open_visual()<CR>',
      mode = 'v',
      desc = 'Search selection',
    },
    {
      '<leader>f',
      '<cmd>lua require("spectre").open_file_search({ select_word = true })<CR>',
      mode = { 'n', 'v' },
      desc = 'Search current file',
    },
  },
  opts = function()
    local sed_args = vim.uv.os_uname().sysname == 'Darwin'
        and { '-i', '', '-E' }
        or { '-i', '-E' }

    return {
      lnum_for_results = true,
      line_sep_start = '┌-----------------------------------------',
      result_padding = '¦  ',
      line_sep = '└-----------------------------------------',
      highlight = {
        ui = 'String',
        search = 'DiffChange',
        delete = 'DiffDelete',
        add = 'DiffAdd',
      },
      find_engine = {
        rg = {
          args = {
            '--color=auto',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
          },
          options = {
            ['ignore-case'] = {
              value = '--ignore-case',
              icon = '[Aa]',
              desc = 'Match case',
            },
            ['whole-word'] = {
              value = '-w',
              icon = '[W]',
              desc = 'Match whole word',
            },
            ['word-regexp'] = {
              value = '--word-regexp',
              icon = '[.*]',
              desc = 'Use regular expression',
            },
          },
        },
      },
      replace_engine = {
        sed = {
          args = sed_args,
        },
      },
    }
  end,
  config = function(_, opts)
    require('spectre').setup(opts)
  end,
}
