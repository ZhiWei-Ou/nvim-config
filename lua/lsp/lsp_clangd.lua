local G = require("lsp.general")

local lsp_clangd_name = 'clangd'
local lsp_clangd_config = {
  name = "C/C++",   -- actual 'Clangd'
  cmd = {
    'clangd',
    '--background-index',
    '--clang-tidy',
    '--header-insertion=never',       -- iwyu, never
    '--all-scopes-completion',
    '--completion-style=bundled',     -- bundled, detailed
    '--enable-config',
    '--function-arg-placeholders=false',
  },
  root_markers = {
    '.clangd',
    '.clang-tidy',
    '.clang-format',
    'compile_commands.json',
    'compile_flags.txt',
    'configure.ac',     -- AutoTools
    '.git',
  },
  capabilities = {
    textDocument = {
      semanticHighlightingCapabilities = {
        semanticHighlighting = true
      },
      completion = {
        editsNearCursor = true,
      },
    },
  },
  offsetEncoding = { 'utf-8', 'utf-16' },
  filetypes = {
    "c", "cpp", "objc", "objcpp", "cc",
    "hh", "hpp", "h", "hxx"
  },
  handlers = {
    ["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover,
      {
        border = 'double',         --  'single', 'double', 'rounded', 'solid', 'shadow'
      }
    ),
    ["textDocument/signatureHelp"] = vim.lsp.with(
      vim.lsp.handlers.signature_help,
      {
        border = 'double',         --  'single', 'double', 'rounded', 'solid', 'shadow'
        close_events = {
          'CursorMoved',
          'BufHidden',
          'InsertCharPre'
        },
      }
    ),
    ['textDocument/references'] = vim.lsp.with(
      vim.lsp.handlers.references,
      {
        border = "double",
        loclist = true,
      }
    ),
  }
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = { 'c', 'h', 'cpp', 'hpp', 'tpp', 'cc', 'hh' },
  callback = function()
    vim.api.nvim_buf_set_option(0, 'commentstring', '// %s')
  end
})

G.configuration(lsp_clangd_name, lsp_clangd_config)
