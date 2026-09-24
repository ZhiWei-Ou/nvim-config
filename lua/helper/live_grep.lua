local M = {}
local preview_namespace = vim.api.nvim_create_namespace('live_grep_matches')

local function decode_text(value)
  return value.text or vim.base64.decode(value.bytes)
end

local function entry_maker(opts)
  local make_entry = require('telescope.make_entry').gen_from_vimgrep(opts)

  return function(line)
    local event = vim.json.decode(line)
    if event.type ~= 'match' then
      return nil
    end

    local data = event.data
    local filename = decode_text(data.path)
    local text = decode_text(data.lines):gsub('\r?\n$', '')
    local col = data.submatches[1] and data.submatches[1].start + 1 or 1
    local value = string.format('%s:%d:%d:%s', filename, data.line_number, col, text)
    local entry = make_entry(value)
    -- JSON supplies these fields unambiguously, including paths containing colons.
    entry.filename = filename
    entry.lnum = data.line_number
    entry.col = col
    entry.text = text
    entry.submatches = data.submatches

    local display = entry.display
    entry.display = function(self)
      local rendered, highlights = display(self)
      highlights = highlights or {}
      -- The standard vimgrep display appends the original text after its path/icon.
      -- Both ripgrep offsets and Neovim highlight columns count bytes, not characters.
      local offset = #rendered - #text
      for _, match in ipairs(data.submatches) do
        local finish = math.min(match['end'], #text)
        if finish > match.start then
          highlights[#highlights + 1] = {
            { offset + match.start, offset + finish },
            'TelescopeMatching',
          }
        end
      end
      return rendered, highlights
    end
    return entry
  end
end

local function grep_previewer(opts)
  local config = require('telescope.config').values
  return require('telescope.previewers').new_buffer_previewer({
    title = 'Grep Preview',
    dyn_title = function(_, entry)
      return entry.filename
    end,
    get_buffer_by_name = function(_, entry)
      return entry.path
    end,
    define_preview = function(self, entry)
      self.state.entry = entry
      config.buffer_previewer_maker(entry.path, self.state.bufnr, {
        bufname = self.state.bufname,
        winid = self.state.winid,
        preview = opts.preview,
        file_encoding = opts.file_encoding,
        callback = function(bufnr)
          -- File reads finish asynchronously; only the current selection may update it.
          if not self.state or self.state.entry ~= entry
              or not vim.api.nvim_buf_is_valid(bufnr)
              or not vim.api.nvim_win_is_valid(self.state.winid) then
            return
          end
          vim.api.nvim_buf_clear_namespace(bufnr, preview_namespace, 0, -1)
          local row = entry.lnum - 1
          local line = vim.api.nvim_buf_get_lines(bufnr, row, row + 1, false)[1]
          if not line then
            return
          end
          vim.api.nvim_buf_set_extmark(bufnr, preview_namespace, row, 0, {
            end_col = #line,
            hl_group = 'TelescopePreviewLine',
            hl_eol = true,
            priority = 100,
          })
          for _, match in ipairs(entry.submatches) do
            local finish = math.min(match['end'], #line)
            if finish > match.start then
              vim.api.nvim_buf_set_extmark(bufnr, preview_namespace, row, match.start, {
                end_col = finish,
                hl_group = 'Search',
                priority = 200,
              })
            end
          end
          vim.api.nvim_win_set_cursor(self.state.winid, { entry.lnum, 0 })
          vim.api.nvim_win_call(self.state.winid, function()
            vim.cmd('normal! zz')
          end)
        end,
      })
    end,
  })
end

function M.live_grep(opts)
  local config = require('telescope.config')
  opts = vim.tbl_extend('force', {}, opts or {})
  local entry_opts = vim.tbl_extend('force', config.values, config.pickers.live_grep or {}, opts)
  local additional_args = entry_opts.additional_args or {}
  if type(additional_args) == 'function' then
    additional_args = additional_args(entry_opts)
  end
  opts.additional_args = vim.list_extend(vim.deepcopy(additional_args), { '--json' })
  opts.entry_maker = entry_maker(entry_opts)
  opts.previewer = grep_previewer(entry_opts)
  -- Highlight the reported matches only; the default sorter adds fuzzy highlights.
  opts.sorter = require('telescope.sorters').empty()
  require('telescope.builtin').live_grep(opts)
end

return M
