local assert = require 'luassert'

describe('theme persistence', function()
  local temp_dir
  local project_cache

  local function read_config()
    return vim.json.decode(table.concat(vim.fn.readfile(vim.g.personal_config), '\n'))
  end

  before_each(function()
    temp_dir = vim.fn.tempname()
    vim.fn.mkdir(temp_dir, 'p')
    vim.g.personal_config = temp_dir .. '/nvim-personal.json'
    vim.fn.writefile({
      vim.json.encode {
        version = tostring(vim.version()),
        logo = { style = 'default' },
        theme = { colorscheme = 'default', background = 'dark' },
      },
    }, vim.g.personal_config)

    package.loaded.config = nil
    package.loaded.theme_mngr = nil
    require 'theme_mngr'
    project_cache = require 'core.project_cache'
  end)

  after_each(function()
    project_cache.setup(temp_dir .. '/outside')
    vim.fn.delete(temp_dir, 'rf')
  end)

  it('keeps project colorschemes out of the global personal config', function()
    vim.cmd.colorscheme 'blue'
    assert.are.same('blue', read_config().theme.colorscheme)

    local root = temp_dir .. '/project'
    vim.fn.mkdir(root .. '/.nvim', 'p')
    vim.fn.writefile({}, root .. '/.nvim/config.lua')
    assert.is_true(project_cache.setup(root))

    vim.cmd.colorscheme 'darkblue'
    assert.are.same('blue', read_config().theme.colorscheme)
    assert.is_true(project_cache.save())
    local cache = vim.json.decode(table.concat(vim.fn.readfile(root .. '/.nvim/cache.json'), '\n'))
    assert.are.same('darkblue', cache.Colorscheme)
  end)
end)
