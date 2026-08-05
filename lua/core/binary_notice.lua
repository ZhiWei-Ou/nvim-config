---@brief detect binary files and replace them with a warning window

local M = {}

local function is_binary_file(path)
  if path == '' or vim.fn.isdirectory(path) == 1 then
    return false
  end

  local file = io.open(path, 'rb')
  if not file then
    return false
  end

  local chunk = file:read(4096) or ''
  file:close()
  return chunk:find('\0', 1, true) ~= nil
end

local function pick_fallback_buf(original_buf)
  local alternate_buf = vim.fn.bufnr '#'
  if alternate_buf > 0 and alternate_buf ~= original_buf and vim.api.nvim_buf_is_valid(alternate_buf) then
    if vim.bo[alternate_buf].buftype == '' and vim.fn.buflisted(alternate_buf) == 1 then
      return alternate_buf, false
    end
  end

  for _, candidate in ipairs(vim.api.nvim_list_bufs()) do
    if candidate ~= original_buf and vim.bo[candidate].buftype == '' and vim.fn.buflisted(candidate) == 1 then
      return candidate, false
    end
  end

  local scratch_buf = vim.api.nvim_create_buf(false, true)
  vim.bo[scratch_buf].buftype = 'nofile'
  vim.bo[scratch_buf].bufhidden = 'hide'
  vim.bo[scratch_buf].swapfile = false
  vim.bo[scratch_buf].modifiable = false
  vim.bo[scratch_buf].readonly = true
  return scratch_buf, true
end

local function open_notice(path, original_buf)
  local previous_win = vim.api.nvim_get_current_win()
  local notice_buf = vim.api.nvim_create_buf(false, true)
  local message = 'This file looks like a binary file and cannot be displayed.'
  local path_line = 'Path: ' .. path
  local width = math.min(vim.o.columns - 4, math.max(#message, #path_line) + 4)
  local height = 5
  local row = math.max(1, math.floor((vim.o.lines - height) / 2) - 1)
  local col = math.max(1, math.floor((vim.o.columns - width) / 2))
  local message_padding = math.max(0, math.floor((width - #message) / 2))
  local path_padding = math.max(0, math.floor((width - #path_line) / 2))

  vim.api.nvim_buf_set_lines(notice_buf, 0, -1, false, {
    '',
    string.rep(' ', message_padding) .. message,
    '',
    string.rep(' ', path_padding) .. path_line,
    '',
  })
  vim.bo[notice_buf].buftype = 'nofile'
  vim.bo[notice_buf].bufhidden = 'wipe'
  vim.bo[notice_buf].swapfile = false
  vim.bo[notice_buf].modifiable = false
  vim.bo[notice_buf].readonly = true

  local fallback_buf, is_scratch = pick_fallback_buf(original_buf)
  if vim.api.nvim_win_is_valid(previous_win) then
    vim.api.nvim_win_set_buf(previous_win, fallback_buf)
  end

  if is_scratch and vim.api.nvim_win_is_valid(previous_win) then
    vim.wo[previous_win].number = false
    vim.wo[previous_win].relativenumber = false
    vim.wo[previous_win].signcolumn = 'no'
  end

  local notice_win = vim.api.nvim_open_win(notice_buf, true, {
    relative = 'editor',
    row = row,
    col = col,
    width = width,
    height = height,
    border = 'rounded',
    style = 'minimal',
  })
  vim.wo[notice_win].number = false
  vim.wo[notice_win].relativenumber = false

  vim.api.nvim_buf_add_highlight(notice_buf, -1, 'WarningMsg', 1, message_padding, message_padding + #message)
  vim.api.nvim_buf_add_highlight(notice_buf, -1, 'Comment', 3, path_padding, path_padding + #path_line)

  vim.keymap.set('n', 'q', function()
    if vim.api.nvim_win_is_valid(notice_win) then
      vim.api.nvim_win_close(notice_win, true)
    end
    if vim.api.nvim_win_is_valid(previous_win) then
      vim.api.nvim_set_current_win(previous_win)
    end
  end, { buffer = notice_buf, nowait = true, silent = true, desc = 'Close binary notice' })

  if is_scratch then
    vim.keymap.set('n', 'q', function()
      if vim.api.nvim_win_is_valid(previous_win) then
        vim.api.nvim_set_current_win(previous_win)
      end
    end, { buffer = fallback_buf, nowait = true, silent = true, desc = 'Close binary scratch buffer' })
  end

  if vim.api.nvim_buf_is_valid(original_buf) then
    vim.api.nvim_buf_delete(original_buf, { force = true })
  end
end

function M.setup()
  vim.api.nvim_create_autocmd('BufReadPost', {
    group = vim.api.nvim_create_augroup('BinaryFileNotice', { clear = true }),
    callback = function(args)
      if vim.bo[args.buf].buftype ~= '' then
        return
      end

      local path = vim.api.nvim_buf_get_name(args.buf)
      if is_binary_file(path) then
        open_notice(path, args.buf)
      end
    end,
    desc = 'Show warning buffer for binary files',
  })
end

return M
