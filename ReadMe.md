# nvim-config
A **Neovim** configuration, integrated with common LSPs and nice themes.

## Table of contents
- [nvim-config](#nvim-config)
  - [Table of contents](#table-of-contents)
- [Neovim version](#neovim-version)
- [💈 Media](#-media)
- [Integration](#integration)
  - [Common Key](#common-key)
  - [Supported LSPs](#supported-lsps)
  - [FAQ](#faq)

# Neovim version
```bash
NVIM v0.11.1
Build type: Release
LuaJIT 2.1.1744318430
```


# Media

<p align="left">
  <img src="assets/dashboard.png" width="300"/>
  <img src="assets/workbench.png" width="300"/>
  <!-- <img src="assets/theme/catppuccin.png" width="300"/> -->
  <!-- <img src="assets/theme/github_dark.png" width="300"/> -->
  <!-- <img src="assets/theme/github_light.png" width="300"/> -->
  <!-- <img src="assets/theme/kanagawa-dragon.png" width="300"/> -->
</p>

# Integration
- install neovim to your system.
- clone this repo to `~/.config/nvim`
```Shell
git clone git@github.com:ZhiWei-Ou/nvim-config.git ~/.config/nvim
```
- run `:PackerSync`
- restart neovim
- enjoy it


## Common Key
|      key      |                 description                 |
| :-----------: | :-----------------------------------------: |
|    Ctrl+s     |                  Save file                  |
|    Ctrl+\     |               Vertical split                |
|    Ctrl+t     |   Open terminal(default display in float)   |
|    Ctrl+l     |            Toggle file explorer             |
| Ctrl+k Ctrl+p | Open telescope(like VScode command palette) |
|      gd       |              Go to definition               |
|      gr       |               Show references               |
|      gh       |                Show comments                |
|      gq       |                 Format code                 |
|      gx       |                Open link under cursor        |
|    Ctrl+o     |               Backward record               |
|    Ctrl+]     |               Toggle outline                |
|  <leader>+dd  |             Toggle diagnostics              |
|    Ctrl+p     |                 Search file                 |
|    Ctrl+f     |                   Search                    |


## Supported LSPs
clangd(C/C++), lua_ls(Lua), gopls(Golang), jsonls(Json), marksman(MarkDown),
cmake(CMake), bashls(Shell), bufls(Protobuf), yamlls(YAML)

## FAQ
1. mason.cmake_language_server error.

Befor using the CMake LSP, you need to install some required tools:

```bash
apt install python3 python3-pip python3.10-venv npm
```

2. clipboard is not work in wsl2.ubuntu2204.
```bash
apt install xclip xsel wl-clipboard
```

3. Icons not displaying correctly.

The icons rely on `Nerd fonts`, You can download and install it from [Nerd Fonts](https://www.nerdfonts.com/).

4. how to open `:help <query>` in full screen?

By default, `:help <query>` opens in a horizontal split. You can use `:help <query> | only` to make it full screen.

However, this does not open it in a buffer.

See [this post](https://www.reddit.com/r/neovim/comments/10383z1/open_help_in_buffer_instead_of_split/).

