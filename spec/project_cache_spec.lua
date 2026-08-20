local assert = require 'luassert'
local project_cache = require 'core.project_cache'

describe('project state cache', function()
  local root

  local function write(path, lines)
    vim.fn.mkdir(vim.fs.dirname(path), 'p')
    vim.fn.writefile(lines or {}, path)
  end

  local function read(path)
    local file = assert(io.open(path, 'r'))
    local content = file:read '*a'
    file:close()
    return content
  end

  local function cache_path()
    return root .. '/.nvim/cache.json'
  end

  local function buffer_state(path, overrides)
    return vim.tbl_extend('force', {
      Path = path,
      Line = 1,
      Column = 0,
    }, overrides or {})
  end

  local function filetype_state(overrides)
    return vim.tbl_extend('force', {
      IndentStyle = 'space',
      IndentSize = 4,
      FormatEnabled = false,
    }, overrides or {})
  end

  before_each(function()
    root = vim.fn.tempname()
    write(root .. '/.nvim/config.lua', {})
    for index = 1, 11 do
      write(string.format('%s/src/file%d.c', root, index), {
        'line one',
        'line two',
        'line three',
      })
    end
    write(root .. '/src/file1.cpp', { 'cpp one', 'cpp two', 'cpp three' })
    vim.cmd 'enew!'
  end)

  after_each(function()
    vim.cmd 'silent! %bwipeout!'
    vim.cmd 'silent! delcommand NvimTreeOpen'
    package.loaded['nvim-tree.core'] = nil
    package.loaded['nvim-tree.api'] = nil
    vim.fn.delete(root, 'rf')
  end)

  it('restores buffer positions and per-filetype settings', function()
    write(cache_path(), {
      vim.json.encode({
        Version = 2,
        Buffers = {
          buffer_state('src/file1.c', { Line = 3, Column = 2 }),
          buffer_state('src/file1.cpp', { Line = 2, Column = 4 }),
        },
        FileTypes = {
          c = filetype_state { IndentStyle = 'tab', IndentSize = 8, FormatEnabled = true },
          cpp = filetype_state { IndentSize = 2 },
        },
        Colorscheme = 'default',
        NvimTreeOpen = false,
      }),
    })

    assert.is_true(project_cache.setup(root .. '/src'))
    local real_root = vim.uv.fs_realpath(root)
    assert.are.same(real_root .. '/src/file1.c', vim.api.nvim_buf_get_name(0))
    assert.are.same({ 3, 2 }, vim.api.nvim_win_get_cursor(0))
    vim.bo.filetype = 'c'
    assert.is_false(vim.bo.expandtab)
    assert.are.same(8, vim.bo.shiftwidth)
    assert.is_true(vim.b.conform_enable)
    assert.is_false(require('portal').should_open())

    vim.cmd('buffer ' .. vim.fn.fnameescape(real_root .. '/src/file1.cpp'))
    vim.bo.filetype = 'cpp'
    assert.are.same({ 2, 4 }, vim.api.nvim_win_get_cursor(0))
    assert.is_true(vim.bo.expandtab)
    assert.are.same(2, vim.bo.shiftwidth)
    assert.is_false(vim.b.conform_enable)

    vim.cmd('edit ' .. vim.fn.fnameescape(real_root .. '/src/new.c'))
    vim.bo.filetype = 'c'
    assert.is_false(vim.bo.expandtab)
    assert.are.same(8, vim.bo.shiftwidth)
    assert.is_true(vim.b.conform_enable)
  end)

  it('pretty-prints ten buffers and project filetype settings separately', function()
    assert.is_true(project_cache.setup(root))

    for index = 1, 11 do
      vim.cmd('edit ' .. vim.fn.fnameescape(string.format('%s/src/file%d.c', root, index)))
    end
    vim.bo.filetype = 'c'
    vim.api.nvim_win_set_cursor(0, { 2, 3 })
    vim.bo.expandtab = false
    vim.bo.tabstop = 8
    vim.bo.shiftwidth = 8
    vim.b.conform_enable = true
    assert.is_true(project_cache.save())

    local content = read(cache_path())
    local cache = vim.json.decode(content)
    assert.are.same(2, cache.Version)
    assert.are.same(10, #cache.Buffers)
    assert.are.same('src/file11.c', cache.Buffers[1].Path)
    assert.are.same('src/file2.c', cache.Buffers[10].Path)
    assert.are.same(2, cache.Buffers[1].Line)
    assert.are.same(3, cache.Buffers[1].Column)
    assert.is_nil(cache.Buffers[1].IndentStyle)
    assert.is_nil(cache.Buffers[1].IndentSize)
    assert.is_nil(cache.Buffers[1].FormatEnabled)
    assert.are.same('tab', cache.FileTypes.c.IndentStyle)
    assert.are.same(8, cache.FileTypes.c.IndentSize)
    assert.is_true(cache.FileTypes.c.FormatEnabled)
    assert.is_nil(cache.Colorscheme)
    assert.is_true(cache.NvimTreeShowDotfiles)
    assert.is_false(cache.NvimTreeShowGitIgnored)
    assert.is_truthy(content:find('\n  "Buffers"', 1, true))
    assert.are.same('\n', content:sub(-1))
  end)

  it('migrates the legacy lowercase buffer list on save', function()
    write(cache_path(), {
      vim.json.encode {
        buffers = { 'src/file1.c', 'src/file2.c' },
      },
    })

    assert.is_true(project_cache.setup(root))
    assert.is_true(project_cache.save())

    local cache = vim.json.decode(read(cache_path()))
    assert.are.same(2, cache.Version)
    assert.is_nil(cache.buffers)
    assert.are.same('src/file1.c', cache.Buffers[1].Path)
    assert.are.same('src/file2.c', cache.Buffers[2].Path)
  end)

  it('migrates legacy per-buffer settings to their filetype', function()
    write(cache_path(), {
      vim.json.encode {
        Version = 1,
        Buffers = {
          {
            Path = 'src/file1.c',
            Line = 1,
            Column = 0,
            IndentStyle = 'tab',
            IndentSize = 8,
            FormatEnabled = true,
          },
        },
      },
    })

    assert.is_true(project_cache.setup(root))
    vim.bo.filetype = 'c'
    assert.is_true(project_cache.save())

    local cache = vim.json.decode(read(cache_path()))
    assert.are.same(2, cache.Version)
    assert.is_nil(cache.Buffers[1].IndentStyle)
    assert.are.same('tab', cache.FileTypes.c.IndentStyle)
    assert.are.same(8, cache.FileTypes.c.IndentSize)
    assert.is_true(cache.FileTypes.c.FormatEnabled)
  end)

  it('clamps cursor positions and ignores missing files', function()
    write(cache_path(), {
      vim.json.encode {
        Version = 1,
        Buffers = {
          buffer_state('src/file1.c', { Line = 99, Column = 99 }),
          buffer_state('src/missing.c'),
        },
        Colorscheme = 'default',
        NvimTreeOpen = false,
      },
    })

    assert.is_true(project_cache.setup(root))
    assert.are.same({ 3, 9 }, vim.api.nvim_win_get_cursor(0))
    assert.is_true(project_cache.save())
    assert.are.same(1, #vim.json.decode(read(cache_path())).Buffers)
  end)

  it('restores and records nvim-tree visibility', function()
    local opened = false
    vim.api.nvim_create_user_command('NvimTreeOpen', function()
      opened = true
      vim.cmd 'vnew'
      vim.bo.filetype = 'NvimTree'
    end, {})
    write(cache_path(), {
      vim.json.encode {
        Version = 1,
        Buffers = { buffer_state('src/file1.c') },
        Colorscheme = 'default',
        NvimTreeOpen = true,
        NvimTreeShowDotfiles = false,
        NvimTreeShowGitIgnored = true,
      },
    })

    assert.is_true(project_cache.setup(root))
    vim.api.nvim_exec_autocmds('VimEnter', {})
    assert.is_true(opened)
    assert.is_true(project_cache.save())
    local cache = vim.json.decode(read(cache_path()))
    assert.is_true(cache.NvimTreeOpen)
    assert.is_false(cache.NvimTreeShowDotfiles)
    assert.is_true(cache.NvimTreeShowGitIgnored)
  end)

  it('restores nvim-tree dotfile and gitignore visibility', function()
    write(cache_path(), {
      vim.json.encode {
        Version = 1,
        Buffers = { buffer_state('src/file1.c') },
        NvimTreeOpen = false,
        NvimTreeShowDotfiles = true,
        NvimTreeShowGitIgnored = true,
      },
    })
    assert.is_true(project_cache.setup(root))

    local filters = { dotfiles = true, git_ignored = true }
    package.loaded['nvim-tree.core'] = {
      get_explorer = function()
        return { filters = { state = filters } }
      end,
    }
    package.loaded['nvim-tree.api'] = {
      filter = {
        dotfiles = {
          toggle = function()
            filters.dotfiles = not filters.dotfiles
          end,
        },
        git = {
          ignored = {
            toggle = function()
              filters.git_ignored = not filters.git_ignored
            end,
          },
        },
      },
    }

    project_cache.restore_nvim_tree_filters()
    assert.is_false(filters.dotfiles)
    assert.is_false(filters.git_ignored)
  end)

  it('uses the Git root when project config is absent', function()
    vim.fn.delete(root .. '/.nvim/config.lua')
    vim.fn.mkdir(root .. '/.git', 'p')

    assert.is_true(project_cache.setup(root .. '/src'))
    vim.cmd('edit ' .. vim.fn.fnameescape(root .. '/src/file1.c'))
    assert.is_true(project_cache.save())
    assert.are.same(1, #vim.json.decode(read(cache_path())).Buffers)
  end)
end)
