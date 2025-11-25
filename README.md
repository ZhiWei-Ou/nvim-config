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

## ⭐ Philosophy & Key Features

This configuration is built with three core principles in mind: **automation**, **aesthetics**, and **efficiency**. It aims to be a "just works" setup that is both powerful and visually pleasing.

-   **Auto-Everything**:
    -   **Automatic Treesitter Installation**: When you open a file of a new language, the required Treesitter parser is **automatically installed** in the background. No manual `:TSInstall` needed.
    -   **On-the-fly Formatting**: Code is automatically formatted on save via `conform.nvim`.
    -   **Lazy-loaded Plugins**: All plugins are lazy-loaded for a fast startup time.

-   **Beautiful & Informative UI**:
    -   **Custom Completion Menu**: The `nvim-cmp` completion menu is meticulously themed with custom icons and a clean layout for a unique look. See `docs/theme.md` for details.
    -   **Symbol Highlighting**: The symbol under your cursor is automatically highlighted after a short delay, making it easy to spot all references.
    -   **Clean & Modern Theme**: A cohesive and beautiful colorscheme.

-   **Efficient Workflow**:
    -   **Powerful Keymaps**: Sensible keybindings are provided for the most common actions. See the section below and `docs/keymaps.md` for more.
    -   **Fast Fuzzy Finding**: `telescope.nvim` is configured for lightning-fast file, text, and command searching.

## 🔑 Default Keymaps

This configuration uses `which-key.nvim` to help you discover keybindings. Press the `<leader>` key (`space`) and wait to see available options.

Here are some of the most important global keybindings:

| Keybinding | Action                                 |
| :--------- | :------------------------------------- |
| `<C-p>`    | Find files                             |
| `<C-F>`    | Find text in files (live grep)         |
| `<C-l>`    | Toggle file explorer                   |
| `<leader>ca` | List code actions for the current symbol |

For a more comprehensive list of keybindings, including those for LSP and specific plugins, please see the **[Keymaps documentation](./docs/keymaps.md)**.

## 🚀 Prerequisites

-   **Neovim v0.9.0** or higher.
-   **Git** for cloning the configuration and managing plugins.
-   A **[Nerd Font](https://www.nerdfonts.com/font-downloads)** (e.g., FiraCode Nerd Font) installed and configured in your terminal.
-   A C compiler for `nvim-treesitter`.
-   `ripgrep` for Telescope's live grep functionality.

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

## 📄 Documentation

For more details on specific configurations, please refer to the `docs/` directory.

-   **[Keymaps](./docs/keymaps.md)**
-   **[Theme](./docs/theme.md)**
-   **[Git Integration](./docs/git.md)**
-   **[Autocommands](./docs/autocmd.md)**

---

*Made with ❤️ and Lua*