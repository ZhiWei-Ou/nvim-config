---@brief user commands

vim.api.nvim_create_user_command('OS', function()
  local system = vim.uv.os_uname()
  print(table.concat({
    'Neovim Version = ' .. tostring(vim.version()),
    'Machine = ' .. system.machine,
    'Release = ' .. system.release,
    'Sysname = ' .. system.sysname,
    'Version = ' .. system.version,
  }, '\n'))
end, { desc = 'Show operating system information' })

vim.api.nvim_create_user_command('StdPath', function()
  print(table.concat({
    'config = ' .. vim.fn.stdpath 'config',
    'data = ' .. vim.fn.stdpath 'data',
    'state = ' .. vim.fn.stdpath 'state',
    'cache = ' .. vim.fn.stdpath 'cache',
    'run = ' .. vim.fn.stdpath 'run',
    'log = ' .. vim.fn.stdpath 'log',
  }, '\n'))
end, { desc = 'Show Neovim standard paths' })

vim.api.nvim_create_user_command('DebugInfo', function()
  local lsp_names = vim.tbl_map(function(client)
    return client.name
  end, vim.lsp.get_clients { bufnr = 0 })

  print(table.concat({
    'LSP = ' .. table.concat(lsp_names, ', '),
    'Filetype = ' .. vim.bo.filetype,
    'SSH = ' .. (vim.env.SSH_TTY and 'Yes' or 'No'),
    'TMUX = ' .. (vim.env.TMUX and 'Yes' or 'No'),
    'Leader = [' .. (vim.g.mapleader or 'NIL') .. ']',
    'Tabstop = ' .. vim.bo.tabstop,
    'Shiftwidth = ' .. vim.bo.shiftwidth,
    'Softtabstop = ' .. vim.bo.softtabstop,
    'Expandtab = ' .. (vim.bo.expandtab and 'Yes' or 'No'),
    'Background = ' .. (vim.o.background == 'dark' and 'Dark' or 'Light'),
  }, '\n'))
end, { desc = 'Show current Neovim debug information' })

vim.api.nvim_create_user_command("Reboot", function()
  local session = vim.fn.stdpath('state') .. '/restart_session.vim'
  vim.cmd('mksession! ' .. vim.fn.fnameescape(session))
  vim.cmd('restart source ' .. vim.fn.fnameescape(session))
end, {
  desc = "Save all buffers and restart Neovim",
})
