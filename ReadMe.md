# Neovim Configuration
NVIM `v0.10.0`
Build type: `Release`

LuaJIT `2.1.1716656478`

# 💈 Media

https://github.com/user-attachments/assets/1e9f9aca-81d2-4556-8638-f46309ea9353

## Platform
Use terminal app is MacOS default terminal.
```shell
$ uname -rsm
Darwin 23.6.0 arm64
```

## Fancy
1. Select Theme
step.1: Ctrl+k Ctrl+p
step.2: Input `colorscheme`
2. About Git
step.1: Ctrl+k Ctrl+p
step.2: Input `git`
3. Code Snippet
Instruction: hpp, cpp, c, h and so on.
more details: [snip_instruction](config/nvim-luasnip.lua)

## Common Key
| key | description |
|:---:|:-----------:|
|Ctrl+s|Save File|
|Ctrl+\ |Vertical Split|
|Ctrl+t|Open Inner Terminal(default display in float)|
|Ctrl+l|Toggler File Explorer|
|Ctrl+k Ctrl+p|Open Telescope entry|
|gd|Go to Definition|
|gr|Show References|
|gh|Show Comments|
|Ctrl+o|Backward Record|
|Ctrl+]|Toggle Outline|
|<leader>+dd|Toggle Diagnostics|
|Ctrl+p|Open Finder|
|Ctrl+f|Open Greper|

## Outline
1. `:Spectre` to open Spectre
2. `Trouble symbols`
3. `Trouble diagnostics`

## Current Support LSP
clangd(C/C++), lua_ls(Lua), gopls(Golang), jsonls(Json), marksman(MarkDown),
cmake(CMake), bashls(Shell), bufls(Protobuf), yamlls(YAML)

## Telescope
1. `:Telescope emoji` to search emoji

## Problem
### LSP
- mason.cmake_language_server error.
   ```bash
   apt install python3 python3-pip python3.10-venv npm
   ```
### LinuxPort
- clipboard is not work in wsl2.ubuntu2204.
    ```bash
    apt install xclip xsel wl-clipboard
    ```

