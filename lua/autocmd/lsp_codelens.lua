---@brief: CodeLens
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client and client:supports_method 'textDocument/codeLens' then
      vim.lsp.codelens.refresh()
      vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
        buffer = bufnr,
        callback = vim.lsp.codelens.refresh,
      })

      vim.keymap.set('n', '<leader>cl', vim.lsp.codelens.run, {
        noremap = true,
        silent = true,
        buffer = bufnr,
        desc = '[C]ode [L]ens Action'
      })

      vim.keymap.set('n', '<leader>cr', vim.lsp.codelens.refresh, {
        noremap = true,
        silent = true,
        buffer = bufnr,
        desc = '[C]ode Lens [R]efresh'
      })
    end
  end,
})
