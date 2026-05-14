<div align="center">
  <img src="https://raw.githubusercontent.com/ZhiWei-Ou/nvim-config/main/assets/logo.png" width="120" style="border-radius: 50%" />
  <h1>Neovim Config</h1>
  <p>A modern, feature-rich, and fast Neovim configuration based on Lua.</p>
</div>

<p align="center">
  <img alt="Neovim Version" src="https://img.shields.io/badge/Neovim-0.9%2B-57A143?style=for-the-badge&logo=neovim&logoColor=white">
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

## Introduction

This is my personal neovim configuration. I usually use it to editing and browsing files.
I will continue to update both Neovim and this configuration regularly to try out new features and improvements.

## 🚀 Prerequisites

-   **Neovim v0.12.2** or higher.
-   **Git** for cloning the configuration and managing plugins.
-   A **[Nerd Font](https://www.nerdfonts.com/font-downloads)** (e.g., FiraCode Nerd Font) installed and configured in your terminal.
-   A C compiler for `nvim-treesitter`.
-   `ripgrep` for Telescope's live grep functionality.
-   `fd` for fast file listing (optional but recommended).
-   `tree-sitter` CLI for managing Treesitter parsers (optional but recommended).

## 📦 Installation

1.  **Backup your old Neovim configuration (if you have one):**

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

    Plugins will be automatically installed on the first launch. You can monitor the progress in the `lazy.nvim` UI.

## FAQ

- **How to install `tree-sitter` CLI?**

  You can install it via `npm`:

  ```bash
  npm install -g tree-sitter-cli
  ```

> [!Warning]
> On some Linux systems, you might encounter a GLIBC version error when installing via `npm`:
> ```error
> sitter-cli/tree-sitter: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.39' not found
> ```

  Or use `cargo`:

  ```bash
  cargo install tree-sitter-cli
  ```

- **What are `rg` and `fd`, and how do I install them?**

  `rg` is `ripgrep`, a fast text searcher used by `telescope.nvim` for live grep.
  `fd` is a fast file finder used by `telescope.nvim` for `find_files`.

  macOS (Homebrew):
  ```bash
  brew install ripgrep fd
  ```

  Ubuntu/Debian:
  ```bash
  sudo apt install ripgrep fd-find
  ```
  Note: on some distros `fd` is installed as `fdfind`.

  Arch:
  ```bash
  sudo pacman -S ripgrep fd
  ```

- **How to enter Lite mode?**

  Lite mode disables heavy plugins (e.g. LSP) and keeps only file explorer and Telescope basics.

  ```bash
  NVIM_LITE=1 nvim
  ```

  Or:
  ```bash
  nvim --cmd "let g:lite_mode=1"
  ```



*Made with ❤️ and Lua*
