<div align="center">
  <h1>Neovim Config</h1>
  <p>A modern, feature-rich, and fast Neovim configuration based on Lua.</p>
</div>

<p align="center">
  <img alt="Neovim Version" src="https://img.shields.io/badge/Neovim-0.12.2%2B-57A143?style=for-the-badge&logo=neovim&logoColor=white">
  <img alt="Language" src="https://img.shields.io/badge/Made%20with-Lua-2C2D72?style=for-the-badge&logo=lua&logoColor=white">
  <a href="https://github.com/ZhiWei-Ou/nvim-config/blob/main/LICENSE">
    <img alt="License" src="https://img.shields.io/github/license/ZhiWei-Ou/nvim-config?style=for-the-badge&color=blue">
  </a>
  <a href="https://github.com/ZhiWei-Ou/nvim-config/stargazers">
    <img alt="GitHub Stars" src="https://img.shields.io/github/stars/ZhiWei-Ou/nvim-config?style=for-the-badge&logo=github&color=yellow">
  </a>
  <a href="https://github.com/ZhiWei-Ou/nvim-config/issues">
    <img alt="GitHub Issues" src="https://img.shields.io/github/issues/ZhiWei-Ou/nvim-config?style=for-the-badge&logo=github">
  </a>
</p>

<p align="center">
  <a href="#installation">Installation</a> ·
  <a href="#language-servers">Language Servers</a> ·
  <a href="#project-local-configuration">Project Configuration</a> ·
  <a href="#faq">FAQ</a>
</p>

## Introduction

This is my personal Neovim configuration for editing and browsing files.
I regularly update both Neovim and this configuration to try new features and
improvements.

## Prerequisites

- **Neovim v0.12.2** or higher.
- **Git** for cloning the configuration and managing plugins.
- A **[Nerd Font](https://www.nerdfonts.com/font-downloads)** (e.g., FiraCode Nerd Font)
  installed and configured in your terminal.
- A **C compiler** for `nvim-treesitter`.
- **`ripgrep`** for Telescope's live grep functionality.
- **`fd`** for fast file listing (optional but recommended).
- **`tree-sitter` CLI** for managing Treesitter parsers (optional but recommended).

## Installation

1.  **Back up your old Neovim configuration (if you have one):**

    ```bash
    # Required
    mv ~/.config/nvim{,.bak}

    # Optional
    mv ~/.local/share/nvim{,.bak}
    mv ~/.local/state/nvim{,.bak}
    mv ~/.cache/nvim{,.bak}
    ```

2.  **Clone this repository:**

    ```bash
    git clone https://github.com/ZhiWei-Ou/nvim-config.git ~/.config/nvim
    ```

3.  **Launch Neovim:**

    ```bash
    nvim
    ```

    Plugins will be automatically installed on the first launch. You can monitor
    the progress in the `lazy.nvim` UI.

## Language Servers

Full mode installs and enables the servers listed in
[mason_lspconfig.lua](lua/plugins/mason_lspconfig.lua). Adding a server to that list opts it into both
installation and activation; installing another server in Mason alone does not
activate it. Server overrides live in `after/lsp/` and inherit nvim-lspconfig's
defaults.

- **Python:** basedpyright for type analysis, completion and hover; Ruff for
  linting, formatting and import organization. The installed pylsp package is not
  automatically enabled.
- **CMake:** neocmakelsp (`neocmake`).
- **Protobuf:** Buf (`buf_ls`).

### Formatting on save

Go formats on save by default; other languages opt in for the current buffer:

| Command | Effect |
| --- | --- |
| `:FormatEnable` | Enable formatting on save for the current buffer. |
| `:FormatDisable` | Disable formatting on save for the current buffer, overriding the language default. |
| `:FormatDisable!` | Disable formatting on save globally. |

- **Go:** organizes imports with gopls (adding missing imports and removing unused
  ones), then formats with gofumpt enabled. Each LSP request has a two-second timeout.
- **Python:** uses Ruff for formatting; organize imports with the LSP code action.

Project formatting preferences are [saved per filetype](#saved-project-state).
An unset preference follows the language default. Existing cached
`FormatEnabled: false` preferences are respected; use `:FormatEnable` once to
enable formatting in such a project.

## Project-local Configuration

Project-specific settings can be placed in `.nvim/config.lua` at the project
root. This configuration searches the startup working directory and its parent
directories for the nearest file, then loads it after the global configuration.

See the [project-local configuration cookbook](docs/project-local-config.html)
for practical formatting, indentation, `:make`, keymap, and command examples.

For example:

```lua
-- .nvim/config.lua
vim.opt.makeprg = 'cmake --build build'
vim.keymap.set('n', '<leader>b', '<cmd>make<CR>', {
  desc = 'Build project',
})
```

### Trusting project files

Project-local files can execute arbitrary Lua, so Neovim only loads files that
you explicitly trust. Review the file first, then trust the current buffer:

```vim
:edit .nvim/config.lua
:trust
```

Restart Neovim from the project directory after trusting it. If the file
contents change, review and trust the new version again.

### Saved project state

For projects with `.nvim/config.lua`, or Git repositories when no project-local
config exists, `.nvim/cache.json` stores:

- The ten most recently visited buffers and their cursor positions.
- Indentation and formatting preferences per project filetype, so C, C++, shell,
  and other filetypes can differ.
- Whether nvim-tree is open and whether it shows dotfiles or git-ignored files.
- A project colorscheme, added only after it is selected in that project.

Starting Neovim from the project without file arguments restores that state and
opens the most recent file instead of the portal.

Add `.nvim/cache.json` to the project's `.gitignore` if the cache should remain
local to each developer.

### Project-specific language servers

To load project-specific LSP configurations from `.nvim/lsp/*.lua`, append the
directory containing `.nvim/config.lua` itself:

```lua
local project_config_dir = vim.fs.dirname(debug.getinfo(1, 'S').source:sub(2))
vim.opt.runtimepath:append(project_config_dir)
```

## FAQ

### How to install `tree-sitter` CLI?

You can install it via **npm**:

```bash
npm install -g tree-sitter-cli
```

> [!WARNING]
> On some Linux systems, you might encounter a GLIBC version error when installing via `npm`:
>
> ```text
> sitter-cli/tree-sitter: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.39' not found
> ```

Or use **Cargo**:

```bash
cargo install tree-sitter-cli
```

### What are `rg` and `fd`, and how do I install them?

`rg` is `ripgrep`, a fast text searcher used by `telescope.nvim` for live grep.
`fd` is a fast file finder used by `telescope.nvim` for `find_files`.

**macOS (Homebrew)**

```bash
brew install ripgrep fd
```

**Ubuntu / Debian**

```bash
sudo apt install ripgrep fd-find
```

> **Note:** On some distros `fd` is installed as `fdfind`.

**Arch Linux**

```bash
sudo pacman -S ripgrep fd
```

### How to enter Lite mode?

Lite mode disables heavy plugins (e.g. LSP) and keeps only file explorer and Telescope basics.

```bash
NVIM_LITE=1 nvim
```

Or:

```bash
nvim --cmd "let g:lite_mode=1"
```

*Made with ❤️ and Lua*
