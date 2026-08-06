local assert = require 'luassert'
local project_cache = require 'core.project_cache'

describe('project buffer cache', function()
  local root

  local function write(path, lines)
    vim.fn.mkdir(vim.fs.dirname(path), 'p')
    vim.fn.writefile(lines or {}, path)
  end

  local function cache_path()
    return root .. '/.nvim/cache.json'
  end

  before_each(function()
    root = vim.fn.tempname()
    write(root .. '/.nvim/config.lua', {})
    for index = 1, 6 do
      write(string.format('%s/src/file%d.c', root, index), { tostring(index) })
    end
    vim.cmd 'enew!'
  end)

  after_each(function()
    vim.cmd 'silent! %bwipeout!'
    vim.fn.delete(root, 'rf')
  end)

  it('restores cached buffers and bypasses the portal', function()
    write(cache_path(), {
      vim.json.encode {
        buffers = { 'src/file1.c', 'src/file2.c', 'src/file3.c' },
      },
    })

    assert.is_true(project_cache.setup(root .. '/src'))
    local real_root = vim.uv.fs_realpath(root)
    assert.are.same(real_root .. '/src/file1.c', vim.api.nvim_buf_get_name(0))
    assert.is_false(require('portal').should_open())

    local restored = vim.tbl_filter(function(bufnr)
      return vim.api.nvim_buf_get_name(bufnr):match('/src/file%d%.c$') ~= nil
    end, vim.api.nvim_list_bufs())
    assert.are.same(3, #restored)
  end)

  it('stores the five most recent project file buffers', function()
    assert.is_true(project_cache.setup(root))

    for index = 1, 6 do
      vim.cmd('edit ' .. vim.fn.fnameescape(string.format('%s/src/file%d.c', root, index)))
    end
    assert.is_true(project_cache.save())

    local cache = vim.json.decode(table.concat(vim.fn.readfile(cache_path()), '\n'))
    assert.are.same({
      'src/file6.c',
      'src/file5.c',
      'src/file4.c',
      'src/file3.c',
      'src/file2.c',
    }, cache.buffers)
  end)

  it('uses the Git root when project config is absent', function()
    vim.fn.delete(root .. '/.nvim/config.lua')
    vim.fn.mkdir(root .. '/.git', 'p')

    assert.is_true(project_cache.setup(root .. '/src'))
    vim.cmd('edit ' .. vim.fn.fnameescape(root .. '/src/file1.c'))
    assert.is_true(project_cache.save())
    assert.are.same(1, #vim.json.decode(table.concat(vim.fn.readfile(cache_path()), '\n')).buffers)
  end)
end)
