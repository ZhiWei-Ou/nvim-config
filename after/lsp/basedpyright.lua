---@type vim.lsp.Config
return {
  settings = {
    basedpyright = {
      -- Ruff owns import organization; keep type analysis enabled here.
      disableOrganizeImports = true,
    },
  },
}
