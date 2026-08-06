---@brief Restore recently used project buffers
---@date 2026-08-06

local M = {}

local limit = 5
local state = {
  root = nil,
  path = nil,
  buffers = {},
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

local function read_cache(root, path)
  local file = io.open(path, 'r')
  if not file then
    return {}
  end

  local content = file:read '*a'
  file:close()

  local ok, cache = pcall(vim.json.decode, content)
  if not ok or type(cache) ~= 'table' or type(cache.buffers) ~= 'table' then
    vim.notify('Ignoring invalid ' .. path, vim.log.levels.WARN, { title = 'Project cache' })
    return {}
  end

  local buffers = {}
  for _, relative_path in ipairs(cache.buffers) do
    if type(relative_path) == 'string' then
      local absolute_path = to_absolute(root, relative_path)
      if absolute_path and not vim.tbl_contains(buffers, absolute_path) then
        table.insert(buffers, absolute_path)
      end
    end
    if #buffers == limit then
      break
    end
  end

  return buffers
end

local function write_cache()
  if not state.root or not state.path then
    return false
  end

  local buffers = {}
  for _, path in ipairs(state.buffers) do
    local relative_path = to_relative(state.root, path)
    if relative_path then
      table.insert(buffers, relative_path)
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

  file:write(vim.json.encode { buffers = buffers })
  file:write '\n'
  file:close()
  return true
end

local function track_buffer(bufnr)
  if not state.root or vim.bo[bufnr].buftype ~= '' then
    return
  end

  local path = vim.fs.normalize(vim.api.nvim_buf_get_name(bufnr))
  if not is_cacheable(state.root, path) then
    return
  end

  state.buffers = vim.tbl_filter(function(item)
    return item ~= path
  end, state.buffers)
  table.insert(state.buffers, 1, path)

  while #state.buffers > limit do
    table.remove(state.buffers)
  end
end

local function restore_buffers()
  if #state.buffers == 0 then
    return false
  end

  vim.cmd('edit ' .. vim.fn.fnameescape(state.buffers[1]))
  for index = 2, #state.buffers do
    vim.cmd('badd ' .. vim.fn.fnameescape(state.buffers[index]))
  end
  return true
end

function M.setup(start_path)
  local root = project_root(start_path)
  if not root then
    return false
  end

  state.root = root
  state.path = vim.fs.joinpath(root, '.nvim', 'cache.json')
  state.buffers = read_cache(root, state.path)

  local group = vim.api.nvim_create_augroup('ProjectBufferCache', { clear = true })
  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost' }, {
    group = group,
    callback = function(event)
      track_buffer(event.buf)
    end,
    desc = 'Track recent project buffers',
  })
  vim.api.nvim_create_autocmd('VimLeavePre', {
    group = group,
    callback = write_cache,
    desc = 'Save recent project buffers',
  })

  if vim.fn.argc() == 0 then
    restore_buffers()
  end

  return true
end

M.save = write_cache

return M
