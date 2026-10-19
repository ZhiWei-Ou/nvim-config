---@brief statusline plugin
---@refer https://github.com/nvim-lualine/lualine.nvim

local function is_named_buffer()
  return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
end

return {
  'nvim-lualine/lualine.nvim',
  enabled = true,
  dependencies = {
    { 'nvim-tree/nvim-web-devicons', opt = true },
  },
  opts = {
    options = {
      component_separators = { left = ' ', right = ' ' },
      section_separators = { left = '', right = '' },
      disabled_filetypes = {
        'dashboard',
        'portal',
        'packer',
        'TelescopePrompt',
        'toggleterm',
      },
      globalstatus = true,
      refresh = {
        refresh_time = 100,
      },
    },
    sections = {
      lualine_a = {
        {
          'mode',
          fmt = function(str)
            return str:sub(1, 1)
          end,
        },
      },
      lualine_b = {
        {
          'branch',
          icon = '',
        },
        {
          'diff',
          symbols = {
            added = ' ',
            modified = ' ',
            removed = ' ',
          },
        },
      },
      lualine_c = {
        {
          'filename',
          path = 1,
          symbols = {
            modified = ' ●',
            readonly = ' ',
            unnamed = '[No Name]',
            newfile = ' ',
          },
        },
      },
      lualine_x = {
        {
          'diagnostics',
          sources = { 'nvim_diagnostic' },
          symbols = {
            error = ' ',
            warn = ' ',
            info = ' ',
            hint = ' ',
          },
        },
        {
          'encoding',
          fmt = string.lower,
          show_bomb = true,
          cond = is_named_buffer,
        },
        {
          'lsp_status',
          icon = '',
          symbols = {
            spinner = '',
            done = '',
            separator = '',
          },
          show_name = false,
        },
        {
          'filetype',
          icon_only = true,
        },
      },
      lualine_y = {
        {
          'progress',
          separator = '',
          padding = { left = 1, right = 0 },
        },
        {
          'location',
          padding = { left = 0, right = 1 },
        },
      },
      lualine_z = {
        { 'filesize', cond = is_named_buffer },
      },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { 'filename' },
      lualine_x = { 'hostname' },
      lualine_y = {},
      lualine_z = {},
    },
    extensions = {
      'trouble',
      'fugitive',
      'nvim-tree',
      'mason',
      'man',
      'toggleterm',
      'oil',
    },
  },
  config = function(_, opts)
    require('lualine').setup(opts)
  end,
}
