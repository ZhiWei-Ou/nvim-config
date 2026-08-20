# Workspace Context

- Mode: work
- Commit: standard

## Project Notes

- Neovim configuration using lazy.nvim.
- Plugin specifications live in `lua/plugins/`; Lite mode selects a curated subset through `lua/plugins_lite/`.
- The full configuration uses the native `portal` module as a logo-only startup screen; it owns the logo styles and its runtime entry is `plugin/portal.lua`.
- Language-server-specific configuration lives in `after/lsp/`.
- Project-local `.nvim/config.lua` is loaded from the nearest parent through `core.project_config` and Neovim's trust mechanism.
- Projects with `.nvim/config.lua`, or Git repositories as a fallback, persist ten recent buffers and cursor positions plus project/filetype indentation and formatting settings and nvim-tree visibility/filter state in `.nvim/cache.json`; a project colorscheme is stored only after the user selects one.
- Keep the existing `spec/` tests unchanged unless the user explicitly requests test work.
