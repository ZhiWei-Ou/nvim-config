# Neovim Configuration
NVIM `v0.10.0`
Build type: `Release`
LuaJIT `2.1.1716656478`

# 💈 Media
https://github.com/ZhiWei-Ou/nvim-config/blob/main/assets/display.mp4

<video width="640" height="360" controls>
  <source src="https://raw.githubusercontent.com/ZhiWei-Ou/nvim-config/blob/main/assets/display.mp4"
  type="video/mp4">
  Your browser does not support the video tag.
</video>


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
|Ctrl+t|Open Inner Terminal(default display in bottom|
|Option+b|Open or Close Directory Browser|
|Ctrl+k Ctrl+p|Open Telescope entry|
|gd|Go to Definition|
|gr|Show References|
|gh|Show Comments|
|Ctrl+o|Backward Record|
|Ctrl+l|choice code snippet when use LuaSnip|

## Common Commands
1. `:Spectre` to open Spectre
2. `Trouble symbols`
3. `Trouble diagnostics`

## Current Support LSP
clangd(C/C++), lua_ls(Lua), gopls(Golang), jsonls(Json), marksman(MarkDown),
cmake(CMake), bashls(Shell), bufls(Protobuf), yamlls(YAML)

## Telescope
1. `:Telescope emoji` to search emoji
