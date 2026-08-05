---@brief clipboard configuration

if vim.env.SSH_TTY then
  vim.g.clipboard = {
    name = 'OSC 52 (SSH Only)',
    copy = {
      ['+'] = require('vim.ui.clipboard.osc52').copy '+',
      ['*'] = require('vim.ui.clipboard.osc52').copy '*',
    },
    paste = {
      ['+'] = require('vim.ui.clipboard.osc52').paste '+',
      ['*'] = require('vim.ui.clipboard.osc52').paste '*',
    },
  }
end

vim.opt.clipboard = 'unnamedplus'
