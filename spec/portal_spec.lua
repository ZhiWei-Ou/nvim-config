local assert = require 'luassert'

describe('portal', function()
  local portal = require 'portal'

  after_each(function()
    if vim.bo.filetype == 'portal' then
      vim.cmd 'bwipeout!'
    end
  end)

  it('renders only the configured logo', function()
    portal.setup {
      logo = { 'PORTAL', 'NVIM' },
    }
    portal.open()

    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local content = vim.tbl_filter(function(line)
      return line:match '%S' ~= nil
    end, lines)

    assert.are.same('portal', vim.bo.filetype)
    assert.are.same({ 'PORTAL', 'NVIM' }, vim.tbl_map(vim.trim, content))
    assert.is_false(vim.bo.modifiable)
    assert.is_false(vim.bo.buflisted)
  end)

  it('recenters after the portal buffer moves to another window', function()
    portal.setup {
      logo = { 'PORTAL' },
    }
    portal.open()

    local original_winid = vim.api.nvim_get_current_win()
    local portal_bufnr = vim.api.nvim_get_current_buf()
    vim.cmd 'vsplit'

    local portal_winid = vim.api.nvim_get_current_win()
    local other_bufnr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_win_set_buf(original_winid, other_bufnr)
    vim.api.nvim_win_set_width(portal_winid, 20)
    vim.api.nvim_exec_autocmds('WinResized', {})

    local content = vim.tbl_filter(function(line)
      return line:match '%S' ~= nil
    end, vim.api.nvim_buf_get_lines(portal_bufnr, 0, -1, false))

    assert.are.same('       PORTAL', content[1])

    vim.api.nvim_win_close(original_winid, true)
  end)
end)
