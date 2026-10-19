---@brief file formatter plugin
---@refer https://github.com/stevearc/conform.nvim


local function organize_go_imports(bufnr)
  local client = vim.lsp.get_clients({ bufnr = bufnr, name = 'gopls' })[1]
  if not client then
    return
  end

  local function request(method, params)
    local response, err = client:request_sync(method, params, 2000, bufnr)
    if not response or response.err then
      vim.notify('Go import organization failed: ' .. tostring(
        response and response.err.message or err
      ), vim.log.levels.WARN)
      return
    end
    return response.result
  end

  -- Complete import edits before Conform formats and writes the buffer.
  local actions = request('textDocument/codeAction', {
    textDocument = vim.lsp.util.make_text_document_params(bufnr),
    range = {
      start = { line = 0, character = 0 },
      ['end'] = { line = 0, character = 0 },
    },
    context = { diagnostics = {}, only = { 'source.organizeImports' } },
  })
  for _, action in ipairs(actions or {}) do
    if not action.disabled then
      if not action.edit and action.data then
        action = request('codeAction/resolve', action)
      end
      if action and action.edit then
        vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
      end
    end
  end
end

return {
  'stevearc/conform.nvim',
  enabled = true,
  opts = {
    default_format_opts = { lsp_format = 'fallback', timeout_ms = 500 },
    formatters_by_ft = {
      c = { 'clang_format' },
      cpp = { 'clang_format' },
      proto = { 'clang_format' },
      -- gopls applies the configured gofumpt rules.
      go = { lsp_format = 'prefer', timeout_ms = 2000 },
      python = { 'ruff_format' },
      javascript = { 'prettier' },
      typescript = { 'prettier' },
      javascriptreact = { 'prettier' },
      typescriptreact = { 'prettier' },
      json = { 'prettier' },
      css = { 'prettier' },
      html = { 'prettier' },
      yaml = { 'prettier' },
      markdown = { 'prettier' },
    },
    format_on_save = function(bufnr)
      if vim.g.conform_disable == true then
        return
      end

      local enabled = vim.b[bufnr].conform_enable
      if enabled == nil then
        enabled = vim.bo[bufnr].filetype == 'go'
      end
      if not enabled then
        return
      end

      if vim.bo[bufnr].filetype == 'go' then
        organize_go_imports(bufnr)
      end
      return {}
    end,
  },
  config = function(_, opts)
    ---@brief Create commands to enable formatting per buffer, or globally with !
    vim.api.nvim_create_user_command('FormatEnable', function(args)
      if args.bang then
        vim.g.conform_disable = false
        return
      end

      vim.b.conform_enable = true
    end, { bang = true })

    ---@brief Create commands to disable formatting per buffer, or globally with !
    vim.api.nvim_create_user_command('FormatDisable', function(args)
      if args.bang then
        vim.g.conform_disable = true
        return
      end

      vim.b.conform_enable = false
    end, { bang = true })

    require('conform').setup(opts)
  end,
}
