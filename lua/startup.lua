vim.g.startuptime = 0 -- stores Neovim startup time in ms

local start = vim.loop.hrtime()
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local elapsed_ms = (vim.loop.hrtime() - start) / 1e6

    vim.g.startuptime = elapsed_ms
  end,
})
