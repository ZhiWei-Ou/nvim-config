vim.api.nvim_create_user_command("Reboot", function()
  local session = vim.fn.stdpath('state') .. '/restart_session.vim'
  vim.cmd('mksession! ' .. vim.fn.fnameescape(session))
  vim.cmd('restart source ' .. vim.fn.fnameescape(session))
end, {
  desc = "Save all buffers and restart Neovim",
})
