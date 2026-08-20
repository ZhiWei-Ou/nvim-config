---@brief Persist and restore project-local Neovim state
---@date 2026-08-20

local M = {}

local cache_version = 2
local limit = 10
local state = {
  root = nil,
  path = nil,
  buffers = {},
  file_types = {},
  restored = {},
  colorscheme = nil,
  nvim_tree_open = false,
  nvim_tree_show_dotfiles = true,
  nvim_tree_show_git_ignored = false,
}

local function project_root(start_path)
  local config_path = require('core.project_config').find(start_path)
  local root
  if config_path then
    root = vim.fs.dirname(vim.fs.dirname(config_path))
  else
    root = vim.fs.root(start_path or vim.uv.cwd(), '.git')
  end

  if not root then
    return nil
  end

  return vim.uv.fs_realpath(root) or vim.fs.normalize(root)
end

local function is_inside(root, path)
  return path:sub(1, #root + 1) == root .. '/'
end

local function is_cacheable(root, path)
  path = vim.fs.normalize(path)
  if not is_inside(root, path) or is_inside(root .. '/.nvim', path) then
    return false
  end

  local stat = vim.uv.fs_stat(path)
  return stat ~= nil and stat.type == 'file'
end

local function to_absolute(root, relative_path)
  local path = vim.fs.normalize(vim.fs.joinpath(root, relative_path))
  if not is_cacheable(root, path) then
    return nil
  end

  return path
end

local function to_relative(root, path)
  if not is_cacheable(root, path) then
    return nil
  end

  return path:sub(#root + 2)
end

local function positive_integer(value)
  return type(value) == 'number' and value >= 1 and value == math.floor(value)
end

local function nonnegative_integer(value)
  return type(value) == 'number' and value >= 0 and value == math.floor(value)
end

local function decode_buffer(root, value)
  local relative_path
  local entry = {}

  if type(value) == 'string' then
    relative_path = value
  elseif type(value) == 'table' then
    relative_path = value.Path
    entry.line = positive_integer(value.Line) and value.Line or 1
    entry.column = nonnegative_integer(value.Column) and value.Column or 0
    if value.IndentStyle == 'space' or value.IndentStyle == 'tab' then
      entry.legacy_indent_style = value.IndentStyle
    end
    if positive_integer(value.IndentSize) then
      entry.legacy_indent_size = value.IndentSize
    end
    entry.legacy_format_enabled = value.FormatEnabled == true
  end

  if type(relative_path) ~= 'string' then
    return nil
  end

  local path = to_absolute(root, relative_path)
  if not path then
    return nil
  end

  entry.path = path
  entry.line = entry.line or 1
  entry.column = entry.column or 0
  return entry
end

local function decode_file_types(value)
  local file_types = {}
  if type(value) ~= 'table' then
    return file_types
  end

  for filetype, profile in pairs(value) do
    if type(filetype) == 'string' and filetype ~= '' and type(profile) == 'table' then
      local indent_style = profile.IndentStyle
      local indent_size = profile.IndentSize
      if (indent_style == 'space' or indent_style == 'tab') and positive_integer(indent_size) then
        file_types[filetype] = {
          indent_style = indent_style,
          indent_size = indent_size,
          format_enabled = profile.FormatEnabled == true,
        }
      end
    end
  end
  return file_types
end

local function read_cache(root, path)
  local file = io.open(path, 'r')
  if not file then
    return {}, {}, nil, false, true, false
  end

  local content = file:read '*a'
  file:close()

  local ok, cache = pcall(vim.json.decode, content)
  if not ok or type(cache) ~= 'table' then
    vim.notify('Ignoring invalid ' .. path, vim.log.levels.WARN, { title = 'Project cache' })
    return {}, {}, nil, false, true, false
  end

  local encoded_buffers = cache.Buffers or cache.buffers
  if type(encoded_buffers) ~= 'table' then
    vim.notify('Ignoring invalid ' .. path, vim.log.levels.WARN, { title = 'Project cache' })
    return {}, {}, nil, false, true, false
  end

  local buffers = {}
  local seen = {}
  for _, value in ipairs(encoded_buffers) do
    local entry = decode_buffer(root, value)
    if entry and not seen[entry.path] then
      table.insert(buffers, entry)
      seen[entry.path] = true
    end
    if #buffers == limit then
      break
    end
  end

  local file_types = decode_file_types(cache.FileTypes)
  local colorscheme = type(cache.Colorscheme) == 'string' and cache.Colorscheme or nil
  local show_dotfiles = true
  if type(cache.NvimTreeShowDotfiles) == 'boolean' then
    show_dotfiles = cache.NvimTreeShowDotfiles
  end
  local show_git_ignored = cache.NvimTreeShowGitIgnored == true
  return buffers, file_types, colorscheme, cache.NvimTreeOpen == true, show_dotfiles, show_git_ignored
end

local function find_entry(path)
  for index, entry in ipairs(state.buffers) do
    if entry.path == path then
      return entry, index
    end
  end
end

local function promote_entry(entry, index)
  if index then
    table.remove(state.buffers, index)
  end
  table.insert(state.buffers, 1, entry)

  while #state.buffers > limit do
    table.remove(state.buffers)
  end
end

local function project_buffer_path(bufnr)
  if not state.root or not vim.api.nvim_buf_is_valid(bufnr) or vim.bo[bufnr].buftype ~= '' then
    return nil
  end

  local path = vim.fs.normalize(vim.api.nvim_buf_get_name(bufnr))
  if path == '' or not is_inside(state.root, path) or is_inside(state.root .. '/.nvim', path) then
    return nil
  end

  return path
end

local function buffer_path(bufnr)
  local path = project_buffer_path(bufnr)
  return path and is_cacheable(state.root, path) and path or nil
end

local function capture_filetype(bufnr)
  if not project_buffer_path(bufnr) then
    return
  end

  local filetype = vim.bo[bufnr].filetype
  if filetype == '' then
    return
  end

  state.file_types[filetype] = {
    indent_style = vim.bo[bufnr].expandtab and 'space' or 'tab',
    indent_size = vim.bo[bufnr].shiftwidth > 0 and vim.bo[bufnr].shiftwidth or vim.bo[bufnr].tabstop,
    format_enabled = vim.b[bufnr].conform_enable == true,
  }
end

local function capture_buffer(bufnr, promote)
  local path = buffer_path(bufnr)
  if not path then
    return
  end

  local entry, index = find_entry(path)
  entry = entry or {
    path = path,
    line = 1,
    column = 0,
  }

  if vim.api.nvim_get_current_buf() == bufnr then
    local ok, cursor = pcall(vim.api.nvim_win_get_cursor, 0)
    if ok then
      entry.line = cursor[1]
      entry.column = cursor[2]
    end
  end

  capture_filetype(bufnr)

  if promote then
    promote_entry(entry, index)
  elseif not index then
    table.insert(state.buffers, entry)
    while #state.buffers > limit do
      table.remove(state.buffers)
    end
  end
end

local function clamp_cursor(bufnr, line, column)
  local line_count = vim.api.nvim_buf_line_count(bufnr)
  line = math.min(math.max(line, 1), math.max(line_count, 1))
  local text = vim.api.nvim_buf_get_lines(bufnr, line - 1, line, true)[1] or ''
  column = math.min(math.max(column, 0), math.max(#text - 1, 0))
  return { line, column }
end

local function restore_filetype(bufnr, entry)
  local filetype = vim.bo[bufnr].filetype
  if filetype == '' then
    return
  end

  local profile = state.file_types[filetype]
  if not profile and entry and entry.legacy_indent_style and entry.legacy_indent_size then
    profile = {
      indent_style = entry.legacy_indent_style,
      indent_size = entry.legacy_indent_size,
      format_enabled = entry.legacy_format_enabled == true,
    }
    state.file_types[filetype] = profile
  end

  if not profile then
    capture_filetype(bufnr)
    return
  end

  vim.bo[bufnr].expandtab = profile.indent_style == 'space'
  vim.bo[bufnr].tabstop = profile.indent_size
  vim.bo[bufnr].softtabstop = profile.indent_size
  vim.bo[bufnr].shiftwidth = profile.indent_size
  vim.b[bufnr].conform_enable = profile.format_enabled
end

local function restore_cursor(bufnr, entry)
  if vim.api.nvim_get_current_buf() == bufnr then
    vim.api.nvim_win_set_cursor(0, clamp_cursor(bufnr, entry.line, entry.column))
  end
end

local function enter_buffer(bufnr)
  local path = buffer_path(bufnr)
  if not path then
    return
  end

  local entry, index = find_entry(path)
  if entry and not state.restored[path] then
    restore_cursor(bufnr, entry)
    state.restored[path] = true
  end

  restore_filetype(bufnr, entry)

  entry = entry or {
    path = path,
    line = 1,
    column = 0,
  }
  promote_entry(entry, index)
  capture_buffer(bufnr, false)
end

local function nvim_tree_is_open()
  for _, tabpage in ipairs(vim.api.nvim_list_tabpages()) do
    for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(tabpage)) do
      local bufnr = vim.api.nvim_win_get_buf(winid)
      if vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].filetype == 'NvimTree' then
        return true
      end
    end
  end
  return false
end

local function capture_nvim_tree_filters()
  local core = package.loaded['nvim-tree.core']
  if not core then
    return
  end

  local explorer = core.get_explorer()
  if not explorer or not explorer.filters or not explorer.filters.state then
    return
  end

  state.nvim_tree_show_dotfiles = explorer.filters.state.dotfiles == false
  state.nvim_tree_show_git_ignored = explorer.filters.state.git_ignored == false
end

local function encode_buffer(entry)
  local relative_path = to_relative(state.root, entry.path)
  if not relative_path then
    return nil
  end

  local encoded = {
    Path = relative_path,
    Line = entry.line,
    Column = entry.column,
  }
  return encoded
end

local function encode_file_types()
  local file_types = {}
  for filetype, profile in pairs(state.file_types) do
    file_types[filetype] = {
      FormatEnabled = profile.format_enabled == true,
      IndentSize = profile.indent_size,
      IndentStyle = profile.indent_style,
    }
  end
  return next(file_types) and file_types or vim.empty_dict()
end

local function write_cache()
  if not state.root or not state.path then
    return false
  end

  capture_filetype(vim.api.nvim_get_current_buf())
  capture_buffer(vim.api.nvim_get_current_buf(), false)
  capture_nvim_tree_filters()

  local buffers = {}
  for _, entry in ipairs(state.buffers) do
    local encoded = encode_buffer(entry)
    if encoded then
      table.insert(buffers, encoded)
    end
    if #buffers == limit then
      break
    end
  end

  vim.fn.mkdir(vim.fs.dirname(state.path), 'p')
  local file = io.open(state.path, 'w')
  if not file then
    vim.notify('Failed to write ' .. state.path, vim.log.levels.ERROR, { title = 'Project cache' })
    return false
  end

  local cache = {
    Version = cache_version,
    Buffers = buffers,
    Colorscheme = state.colorscheme,
    FileTypes = encode_file_types(),
    NvimTreeOpen = nvim_tree_is_open(),
    NvimTreeShowDotfiles = state.nvim_tree_show_dotfiles,
    NvimTreeShowGitIgnored = state.nvim_tree_show_git_ignored,
  }
  file:write(vim.json.encode(cache, { indent = '  ', sort_keys = true }))
  file:write '\n'
  file:close()
  return true
end

local function colorscheme_exists(name)
  return type(name) == 'string' and vim.tbl_contains(vim.fn.getcompletion('', 'color'), name)
end

local function restore_colorscheme()
  if colorscheme_exists(state.colorscheme) then
    vim.cmd.colorscheme(state.colorscheme)
  end
end

local function restore_buffers()
  if #state.buffers == 0 then
    return false
  end

  vim.cmd('edit ' .. vim.fn.fnameescape(state.buffers[1].path))
  for index = 2, #state.buffers do
    vim.fn.bufadd(state.buffers[index].path)
  end
  return true
end

local function open_nvim_tree()
  if vim.fn.exists(':NvimTreeOpen') ~= 2 then
    return
  end

  local winid = vim.api.nvim_get_current_win()
  vim.cmd 'NvimTreeOpen'
  if vim.api.nvim_win_is_valid(winid) then
    vim.api.nvim_set_current_win(winid)
  end
end

function M.setup(start_path)
  local root = project_root(start_path)
  if not root then
    state.root = nil
    state.path = nil
    return false
  end

  state.root = root
  state.path = vim.fs.joinpath(root, '.nvim', 'cache.json')
  state.buffers, state.file_types, state.colorscheme, state.nvim_tree_open, state.nvim_tree_show_dotfiles,
    state.nvim_tree_show_git_ignored = read_cache(root, state.path)
  state.restored = {}

  restore_colorscheme()

  local group = vim.api.nvim_create_augroup('ProjectBufferCache', { clear = true })
  vim.api.nvim_create_autocmd('BufEnter', {
    group = group,
    callback = function(event)
      enter_buffer(event.buf)
    end,
    desc = 'Restore and track project buffer state',
  })
  vim.api.nvim_create_autocmd('BufLeave', {
    group = group,
    callback = function(event)
      capture_filetype(event.buf)
      capture_buffer(event.buf, false)
    end,
    desc = 'Capture project buffer state',
  })
  vim.api.nvim_create_autocmd('FileType', {
    group = group,
    callback = function(event)
      local path = project_buffer_path(event.buf)
      if path then
        local entry = find_entry(path)
        restore_filetype(event.buf, entry)
      end
    end,
    desc = 'Restore project filetype settings',
  })
  vim.api.nvim_create_autocmd('VimLeavePre', {
    group = group,
    callback = write_cache,
    desc = 'Save project state',
  })
  vim.api.nvim_create_autocmd('ColorScheme', {
    group = group,
    callback = function(event)
      state.colorscheme = event.match
    end,
    desc = 'Remember user-selected project colorscheme',
  })

  if vim.fn.argc() == 0 then
    restore_buffers()
    if state.nvim_tree_open then
      vim.api.nvim_create_autocmd('VimEnter', {
        group = group,
        once = true,
        callback = open_nvim_tree,
        desc = 'Restore nvim-tree visibility',
      })
    end
  else
    enter_buffer(vim.api.nvim_get_current_buf())
  end

  return true
end

function M.is_active()
  return state.root ~= nil
end

function M.restore_nvim_tree_filters()
  if not state.root then
    return
  end

  local core = package.loaded['nvim-tree.core']
  local api = package.loaded['nvim-tree.api']
  if not core or not api then
    return
  end

  local explorer = core.get_explorer()
  if not explorer or not explorer.filters or not explorer.filters.state then
    return
  end

  local filters = explorer.filters.state
  if (filters.dotfiles == false) ~= state.nvim_tree_show_dotfiles then
    api.filter.dotfiles.toggle()
  end
  if (filters.git_ignored == false) ~= state.nvim_tree_show_git_ignored then
    api.filter.git.ignored.toggle()
  end
end

M.save = write_cache

return M
