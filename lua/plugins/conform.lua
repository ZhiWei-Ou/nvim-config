---@brief file formatter plugin
---@refer https://github.com/stevearc/conform.nvim


---@brief define a flag for conform, used to control the formatting

return {
  'stevearc/conform.nvim',
  enabled = true,
  opts = {
    formatters_by_ft = {
      c = { 'clang_format' },
      cpp = { 'clang_format' },
      proto = { 'clang_format' },
      go = { 'gofmt', 'goimports', top_after_first = true },
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
    format_on_save = function()
      if vim.g.conform_disable == true then
        return
      end

      if vim.b.conform_enable == false or vim.b.conform_enable == nil then
        return
      end
      return { timeout_ms = 500, lsp_format = 'fallback' }
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
