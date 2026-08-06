---@brief Minimal logo-only startup portal
---@date 2026-08-06

local M = {}

local config = {
  logo = function()
    return require('portal.logo_manager').get_logo_from_config()
  end,
}

local group = vim.api.nvim_create_augroup('Portal', { clear = true })
local resize_group = vim.api.nvim_create_augroup('PortalResize', { clear = true })
local namespace = vim.api.nvim_create_namespace('Portal')

local function resolve_logo()
  if type(config.logo) == 'function' then
    return config.logo()
  end

  return config.logo
end

local function centered_lines(logo, width, height)
  local lines = {}
  local top = math.max(0, math.floor((height - #logo) / 2))

  for _ = 1, top do
    table.insert(lines, '')
  end

  for _, line in ipairs(logo) do
    local left = math.max(0, math.floor((width - vim.api.nvim_strwidth(line)) / 2))
    table.insert(lines, string.rep(' ', left) .. line)
  end

  return lines
end

local function configure_buffer(bufnr)
  vim.bo[bufnr].bufhidden = 'wipe'
  vim.bo[bufnr].buflisted = false
  vim.bo[bufnr].buftype = 'nofile'
  vim.bo[bufnr].filetype = 'portal'
  vim.bo[bufnr].swapfile = false
end

local function configure_window(winid)
  vim.wo[winid].colorcolumn = ''
  vim.wo[winid].cursorcolumn = false
  vim.wo[winid].cursorline = false
  vim.wo[winid].foldcolumn = '0'
  vim.wo[winid].list = false
  vim.wo[winid].number = false
  vim.wo[winid].relativenumber = false
  vim.wo[winid].signcolumn = 'no'
  vim.wo[winid].spell = false
  vim.wo[winid].wrap = false
end

local function is_empty_buffer(bufnr)
  return vim.api.nvim_buf_get_name(bufnr) == ''
    and not vim.bo[bufnr].modified
    and vim.api.nvim_buf_line_count(bufnr) == 1
    and vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1] == ''
end

function M.should_open()
  if vim.fn.argc() ~= 0 or not is_empty_buffer(0) then
    return false
  end

  for _, arg in ipairs(vim.v.argv) do
    if arg == '-' then
      return false
    end
  end

  return true
end

function M.render(bufnr, winid)
  if not vim.api.nvim_buf_is_valid(bufnr) or not vim.api.nvim_win_is_valid(winid) then
    return
  end

  local logo = resolve_logo()
  local lines = centered_lines(logo, vim.api.nvim_win_get_width(winid), vim.api.nvim_win_get_height(winid))

  vim.bo[bufnr].modifiable = true
  vim.api.nvim_buf_clear_namespace(bufnr, namespace, 0, -1)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)

  local first_logo_line = math.max(0, #lines - #logo)
  for row = first_logo_line, #lines - 1 do
    vim.api.nvim_buf_add_highlight(bufnr, namespace, 'PortalLogo', row, 0, -1)
  end

  vim.bo[bufnr].modifiable = false
  vim.bo[bufnr].modified = false
end

function M.open()
  local winid = vim.api.nvim_get_current_win()
  local bufnr = vim.api.nvim_get_current_buf()

  if vim.bo[bufnr].filetype ~= 'portal' and not is_empty_buffer(bufnr) then
    bufnr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_win_set_buf(winid, bufnr)
  end

  configure_buffer(bufnr)
  configure_window(winid)
  M.render(bufnr, winid)

  vim.api.nvim_clear_autocmds { group = resize_group }
  vim.api.nvim_create_autocmd({ 'VimResized', 'WinResized' }, {
    group = resize_group,
    callback = function()
      if not vim.api.nvim_buf_is_valid(bufnr) then
        return true
      end

      local windows = vim.fn.win_findbuf(bufnr)
      if #windows == 0 then
        return true
      end

      for _, portal_winid in ipairs(windows) do
        M.render(bufnr, portal_winid)
      end
    end,
    desc = 'Keep the portal logo centered',
  })
end

function M.setup(opts)
  config = vim.tbl_deep_extend('force', config, opts or {})
  require('portal.logo_manager').setup()

  vim.api.nvim_set_hl(0, 'PortalLogo', { default = true, link = 'Title' })

  vim.api.nvim_create_user_command('Portal', M.open, {
    force = true,
    desc = 'Open the startup portal',
  })

  vim.api.nvim_create_autocmd('VimEnter', {
    group = group,
    once = true,
    callback = function()
      if M.should_open() then
        M.open()
      end
    end,
    desc = 'Open the portal on an empty startup',
  })
end

return M
