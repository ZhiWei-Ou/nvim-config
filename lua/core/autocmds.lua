-- lua/core/autocmds.lua
---@brief 自动命令
---@date 2025-12-11

---@section
---@brief Highlight symbol under cursor
vim.o.updatetime = 500 -- CursorHold & CursorHoldI Expect Time (ms)
local lsp_highlight_group = vim.api.nvim_create_augroup('LspHighlight', { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
  group = lsp_highlight_group,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client or not client.server_capabilities.documentHighlightProvider then
      return
    end

    local bufnr = args.buf
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      group = lsp_highlight_group,
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
      desc = "Highlight symbol under cursor",
    })
    vim.api.nvim_create_autocmd('CursorMoved', {
      group = lsp_highlight_group,
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
      desc = "Clear symbol highlights",
    })
  end,
  desc = "Setup LSP document highlight autocmds",
})
---@endsection

---@section
---@brief Detect binary files and show a warning buffer
local function is_binary_file(path)
  if path == "" or vim.fn.isdirectory(path) == 1 then
    return false
  end

  local fd = io.open(path, "rb")
  if not fd then
    return false
  end

  local chunk = fd:read(4096) or ""
  fd:close()

  return chunk:find("\0", 1, true) ~= nil
end

local function open_binary_notice(path, orig_buf)
  local prev_win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_create_buf(false, true)
  local msg = "This file looks like a binary file and cannot be displayed."
  local path_line = "Path: " .. path
  local content_width = math.max(#msg, #path_line)
  local width = math.min(vim.o.columns - 4, content_width + 4)
  local height = 5
  local row = math.max(1, math.floor((vim.o.lines - height) / 2) - 1)
  local col = math.max(1, math.floor((vim.o.columns - width) / 2))
  local pad_msg = math.max(0, math.floor((width - #msg) / 2))
  local pad_path = math.max(0, math.floor((width - #path_line) / 2))

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
    "",
    string.rep(" ", pad_msg) .. msg,
    "",
    string.rep(" ", pad_path) .. path_line,
    "",
  })

  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].swapfile = false
  vim.bo[buf].modifiable = false
  vim.bo[buf].readonly = true

  local function pick_fallback_buf()
    local alt = vim.fn.bufnr("#")
    if alt > 0 and alt ~= orig_buf and vim.api.nvim_buf_is_valid(alt) then
      if vim.bo[alt].buftype == "" and vim.fn.buflisted(alt) == 1 then
        return alt, false
      end
    end

    for _, candidate in ipairs(vim.api.nvim_list_bufs()) do
      if candidate ~= orig_buf and vim.bo[candidate].buftype == "" and vim.fn.buflisted(candidate) == 1 then
        return candidate, false
      end
    end

    local scratch_buf = vim.api.nvim_create_buf(false, true)
    vim.bo[scratch_buf].buftype = "nofile"
    vim.bo[scratch_buf].bufhidden = "hide"
    vim.bo[scratch_buf].swapfile = false
    vim.bo[scratch_buf].modifiable = false
    vim.bo[scratch_buf].readonly = true
    return scratch_buf, true
  end

  local fallback_buf, is_scratch = pick_fallback_buf()

  if vim.api.nvim_win_is_valid(prev_win) then
    vim.api.nvim_set_current_win(prev_win)
    vim.api.nvim_win_set_buf(prev_win, fallback_buf)
  end

  if is_scratch and vim.api.nvim_win_is_valid(prev_win) then
    vim.wo[prev_win].number = false
    vim.wo[prev_win].relativenumber = false
    vim.wo[prev_win].signcolumn = "no"
  end

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    row = row,
    col = col,
    width = width,
    height = height,
    border = "rounded",
    style = "minimal",
  })

  vim.wo[win].number = false
  vim.wo[win].relativenumber = false

  vim.api.nvim_buf_add_highlight(buf, -1, "WarningMsg", 1, pad_msg, pad_msg + #msg)
  vim.api.nvim_buf_add_highlight(buf, -1, "Comment", 3, pad_path, pad_path + #path_line)

  vim.keymap.set("n", "q", function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
    if vim.api.nvim_win_is_valid(prev_win) then
      vim.api.nvim_set_current_win(prev_win)
    end
  end, { buffer = buf, nowait = true, silent = true, desc = "Close binary notice" })

  if is_scratch then
    vim.keymap.set("n", "q", function()
      if vim.api.nvim_win_is_valid(prev_win) then
        vim.api.nvim_set_current_win(prev_win)
      end
    end, { buffer = fallback_buf, nowait = true, silent = true, desc = "Close binary scratch buffer" })
  end

  if vim.api.nvim_buf_is_valid(orig_buf) then
    vim.api.nvim_buf_delete(orig_buf, { force = true })
  end
end

vim.api.nvim_create_autocmd('BufReadPost', {
  group = vim.api.nvim_create_augroup('BinaryFileNotice', { clear = true }),
  callback = function(args)
    local buf = args.buf
    if vim.bo[buf].buftype ~= "" then
      return
    end

    local path = vim.api.nvim_buf_get_name(buf)
    if not is_binary_file(path) then
      return
    end

    open_binary_notice(path, buf)
  end,
  desc = "Show warning buffer for binary files",
})
---@endsection
