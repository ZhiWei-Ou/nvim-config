# Keymaps

This configuration uses `which-key.nvim` to help you discover keybindings. Press the `<leader>` key (which is `space` by default) and wait a moment to see a popup with available mappings.

This document highlights the most important global keybindings that are not plugin-specific.

## Global Keybindings

| Keybinding | Action                                           | Plugin                |
| :--------- | :----------------------------------------------- | :-------------------- |
| `<C-p>`    | Find files                                       | `telescope.nvim`      |
| `<C-F>`    | Find text in files (live grep)                   | `telescope.nvim`      |
| `<C-l>`    | Toggle file explorer                             | `nvim-tree.lua`       |
| `<C-k><C-p>` | Open Telescope to find commands (e.g., `theme`) | `telescope.nvim`      |

## LSP & Coding

These keybindings are active when an LSP server is attached to the buffer.

| Keybinding    | Action                  | Plugin           |
| :------------ | :---------------------- | :--------------- |
| `gd`          | Go to definition        | `nvim-lspconfig` |
| `gr`          | Go to references        | `nvim-lspconfig` |
| `K`           | Show hover documentation| `nvim-lspconfig` |
| `<leader>rn`  | Rename symbol           | `nvim-lspconfig` |
| `<leader>ca`  | Code actions            | `nvim-lspconfig` |
| `<leader>cl`  | Run CodeLens action     | `nvim-lspconfig` |
| `<leader>cr`  | Refresh CodeLens actions| `nvim-lspconfig` |
| `[d` / `]d`  | Go to previous/next diagnostic | `nvim-lspconfig` |

Refer to individual plugin files in `lua/plugins/` for more specific mappings.
