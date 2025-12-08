--- @brief: nvim lspconfig plugin
--- @refer: https://github.com/neovim/nvim-lspconfig

--[[
    all of lsp configurations

    @refer: https://neovim.io/doc/user/lsp.html
    The following keymaps are created unconditionally when Nvim starts:
    gra gri grn grr grt i_CTRL-S v_an v_in These GLOBAL keymaps are created unconditionally when Nvim starts:
    "gra" is mapped in Normal and Visual mode to vim.lsp.buf.code_action()
    "gri" is mapped in Normal mode to vim.lsp.buf.implementation()
    "grn" is mapped in Normal mode to vim.lsp.buf.rename()
    "grr" is mapped in Normal mode to vim.lsp.buf.references()
    "grt" is mapped in Normal mode to vim.lsp.buf.type_definition()
    "gO" is mapped in Normal mode to vim.lsp.buf.document_symbol()
    CTRL-S is mapped in Insert mode to vim.lsp.buf.signature_help()
    "an" and "in" are mapped in Visual mode to outer and inner incremental selections, respectively, using vim.lsp.buf.selection_range()
]]

return {
  'neovim/nvim-lspconfig',
  dependencies = { 'hrsh7th/nvim-cmp' },
  keys = {
    {
      'gd',
      function()
        vim.lsp.buf.definition()
      end,
      mode = { 'n' },
      desc = 'Go to definition'
    },
    {
      'gh',
      function()
        vim.lsp.buf.signature_help()
      end,
      mode = { 'i' },
      desc = 'Signature help'
    },
    {
      'K',
      function()
        -- rounded, single , solid, double, none
        vim.lsp.buf.hover({ border = 'rounded' })
      end,
      mode = { 'n' },
      desc = 'Hover'
    },
    {
      'gr',
      function()
        vim.lsp.buf.references()
      end,
      mode = { 'n' },
      desc = 'Show symbol references using telescope'
    },
    {
      'gt',
      function()
        vim.lsp.buf.type_definition()
      end,
      mode = { 'n' },
      desc = 'Go to type definition'
    },
    {
      'gD',
      function()
        vim.lsp.buf.declaration()
      end,
      mode = { 'n' },
      desc = 'Go to declaration'
    },
    {
      '<C-x><C-o>',
      function()
        vim.lsp.buf.code_action()
      end,
      mode = { 'n' },
      desc = 'Code action'
    },
    {
      '<C-x><C-r>',
      function()
        vim.lsp.buf.rename()
      end,
      mode = { 'n' },
      desc = 'Rename symbol'
    }
  },
  init = function()
  end,
  config = function()
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    vim.lsp.config(
      '*',
      {
        root_markers = { '.git' },
        capabilities = capabilities
      }
    )

    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = '✘',
          [vim.diagnostic.severity.WARN]  = '▲',
          [vim.diagnostic.severity.INFO]  = '»',
          [vim.diagnostic.severity.HINT]  = '⚑',
        },
      },
      virtual_text = true,
      severity_sort = true,
      float = {
        border = 'rounded',
        source = true,
      },
    })

    --- @brief: open float diagnostic
    vim.api.nvim_create_user_command("Diagnostic", 'lua vim.diagnostic.open_float()', { nargs = 0 })

    --- @brief: toggle inlay hint
    vim.api.nvim_create_user_command("Hint",
      function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, { nargs = 0 })

    --- @breif: run lens
    vim.api.nvim_create_user_command("Lenses", 'lua vim.lsp.codelens.run()', { nargs = 0 })
  end,
}
