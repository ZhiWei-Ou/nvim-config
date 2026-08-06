local assert = require 'luassert'
local project_config = require 'core.project_config'

describe('project config', function()
  it('finds the nearest config from a nested directory', function()
    local root = vim.fs.normalize(vim.fn.getcwd() .. '/spec/fixtures/project')

    assert.are.same(root .. '/.nvim/config.lua', project_config.find(root .. '/src'))
  end)

  it('executes trusted config content', function()
    local secure_read = vim.secure.read
    vim.secure.read = function()
      return 'vim.g.project_config_test_loaded = true'
    end

    local root = vim.fs.normalize(vim.fn.getcwd() .. '/spec/fixtures/project')
    local ok = project_config.load(root)

    vim.secure.read = secure_read
    assert.is_true(ok)
    assert.is_true(vim.g.project_config_test_loaded)
    vim.g.project_config_test_loaded = nil
  end)

  it('does not execute untrusted config content', function()
    local secure_read = vim.secure.read
    vim.secure.read = function()
      return nil
    end

    local root = vim.fs.normalize(vim.fn.getcwd() .. '/spec/fixtures/project')
    local ok = project_config.load(root)

    vim.secure.read = secure_read
    assert.is_false(ok)
  end)
end)
