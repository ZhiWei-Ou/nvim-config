# Workspace Context

- Mode: work
- Commit: standard

## Project Notes

- Neovim configuration using lazy.nvim.
- Plugin specifications live in `lua/plugins/`; Lite mode selects a curated subset through `lua/plugins_lite/`.
- Language-server-specific configuration lives in `after/lsp/`.
- Project-local `.nvim.lua` files are enabled through Neovim's native `exrc` and trust mechanism.
- Keep the existing `spec/` tests unchanged unless the user explicitly requests test work.
