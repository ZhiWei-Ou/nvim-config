---@brief statusline plugin
---@refer https://github.com/nvim-lualine/lualine.nvim

local copilot_icon = ''

local function is_named_buffer()
  return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
end

local function copilot_state()
  if vim.fn.exists('*copilot#Enabled') == 0 then
    return 'off'
  end

  local enabled_ok, enabled = pcall(vim.fn['copilot#Enabled'])
  if not enabled_ok or enabled ~= 1 then
    return 'off'
  end

  if vim.fn.exists('*copilot#RunningClient') == 0 then
    return 'idle'
  end

  local client_ok, client = pcall(vim.fn['copilot#RunningClient'])
  if not client_ok or client == vim.NIL or client == nil then
    return 'idle'
  end

  local attach_ok, attached = pcall(function()
    return client.IsAttached(vim.api.nvim_get_current_buf())
  end)
  if not attach_ok or not attached or attached == 0 then
    return 'idle'
  end

  return 'ready'
end

local function copilot_status()
  local state = copilot_state()

  if state == 'ready' then
    return copilot_icon .. ' ready'
  elseif state == 'idle' then
    return copilot_icon .. ' idle'
  end

  return copilot_icon .. ' off'
end

local function copilot_color()
  local state = copilot_state()

  if state == 'ready' then
    return { fg = '#7ee787', gui = 'bold' }
  elseif state == 'idle' then
    return { fg = '#d29922' }
  end

  return { fg = '#8b949e' }
end

local function refresh_lualine()
  local ok, lualine = pcall(require, 'lualine')
  if ok and type(lualine.refresh) == 'function' then
    pcall(lualine.refresh, { place = { 'statusline' } })
  else
    pcall(vim.cmd.redrawstatus)
  end
end

local function start_copilot_status_refresh()
  local uv = vim.uv or vim.loop
  if not uv then
    return
  end

  if _G.__lualine_copilot_status_timer then
    _G.__lualine_copilot_status_timer:stop()
    _G.__lualine_copilot_status_timer:close()
    _G.__lualine_copilot_status_timer = nil
  end

  local last_state = copilot_state()
  local timer = uv.new_timer()
  if not timer then
    return
  end

  timer:start(250, 500, vim.schedule_wrap(function()
    local state = copilot_state()
    if state == last_state then
      return
    end

    last_state = state
    refresh_lualine()
  end))
  _G.__lualine_copilot_status_timer = timer

  local group = vim.api.nvim_create_augroup('LualineCopilotStatus', { clear = true })
  vim.api.nvim_create_autocmd({ 'BufEnter', 'FileType', 'InsertEnter', 'InsertLeave', 'VimResume' }, {
    group = group,
    callback = function()
      last_state = copilot_state()
      refresh_lualine()
    end,
    desc = 'Refresh lualine when Copilot buffer state may change',
  })
  vim.api.nvim_create_autocmd('VimLeavePre', {
    group = group,
    callback = function()
      if _G.__lualine_copilot_status_timer then
        _G.__lualine_copilot_status_timer:stop()
        _G.__lualine_copilot_status_timer:close()
        _G.__lualine_copilot_status_timer = nil
      end
    end,
    desc = 'Stop lualine Copilot status timer',
  })
end

return {
  'nvim-lualine/lualine.nvim',
  enabled = true,
  dependencies = {
    { 'nvim-tree/nvim-web-devicons', opt = true },
    { 'echasnovski/mini.nvim',       opt = true },
  },
  opts = {
    options = {
      icons_enabled = true,
      theme = 'auto',
      component_separators = { left = ' ', right = ' ' },
      section_separators = { left = '', right = '' },
      disabled_filetypes = {
        statusline = {},
        winbar = {},
        'dashboard',
        'packer',
        'TelescopePrompt',
        -- 'trouble',
        'toggleterm',
        -- 'NvimTree',
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = true,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
        refresh_time = 100,
        events = {
          'WinEnter',
          'BufEnter',
          'BufWritePost',
          'SessionLoadPost',
          'FileChangedShellPost',
          'VimResized',
          'Filetype',
          'CursorMoved',
          'CursorMovedI',
          'ModeChanged',
        },
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
          file_status = true,     -- Displays file status (readonly status, modified status)
          newfile_status = false, -- Display new file status (new file means no write after created)
          path = 1,               -- Relative path
          -- 2: Absolute path
          -- 3: Absolute path, with tilde as the home directory
          -- 4: Filename and parent dir, with tilde as the home directory

          shorting_target = 40, -- Shortens path to leave 40 spaces in the window
          -- for other components. (terrible name, any suggestions?)
          -- It can also be a function that returns
          -- the value of `shorting_target` dynamically.
          symbols = {
            modified = ' ●', -- Text to show when the file is modified.
            readonly = ' ', -- Text to show when the file is non-modifiable or readonly.
            unnamed = '[No Name]', -- Text to show for unnamed buffers.
            newfile = ' ', -- Text to show for newly created file before first write
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
          -- List of LSP names to ignore (e.g., `null-ls`):
          ignore_lsp = { 'GitHub Copilot' },
          -- Display the LSP name
          show_name = false,
        },
        {
          copilot_status,
          color = copilot_color,
        },
        {
          'filetype',
          colored = true,   -- Displays filetype icon in color if set to true
          icon_only = true, -- Display only an icon for filetype
          icon = { align = 'left' },
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
    tabline = {},
    winbar = {},
    inactive_winbar = {},
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
    start_copilot_status_refresh()
  end,
}
