# Neovim Configuration
NVIM `v0.10.0`
Build type: `Release`
LuaJIT `2.1.1716656478`
[demo-video](./assets/nvim-demo.mov)

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
|Ctrl+\\|Vertical Split|
|Ctrl+t|Open Inner Terminal(default display in bottom|
|Option+b|Open or Close Directory Browser|
|Ctrl+k Ctrl+p|Open Telescope entry|
|gd|Go to Definition|
|gr|Show References|
|gh|Show Comments|
|Ctrl+o|Backward Record|
|Ctrl+l|choice code snippet when use LuaSnip|

## Current Support LSP
clangd(C/C++), lua_ls(Lua), gopls(Golang), jsonls(Json), marksman(MarkDown),
cmake(CMake), bashls(Shell), bufls(Protobuf), yamlls(YAML)

## Plugins
| numbers |  plugin | description |
|:-------:|:-------:|:-----------:|
|1|LuaSnip| [nvim-luasnip.lua](lua/config/nvim-luasnip.lua)|
|2|bufferline| [nvim-bufferline.lua](lua/config/nvim-bufferline.lua)|
|3|cmake-tools| [nvim-cmake](lua/config/nvim-cmake.lua)|
|4|cmp-buffer||
|5|cmp-cmdline||
|6|cmp-nvim-lsp||
|7|cmp-nvim-lua||
|8|cmp-path||
|9|cmp-luasnipt||
|10|codeium||
|11|dressing||
|12|dressing||
|13|github-nvim-theme||
|14|gitsigns||
|15|lspkind-nvim||
|16|lualine-nvim||
|17|mason-lspconfig||
|18|mason||
|19|nvim-cmp||
|20|nvim-lspconfig||
|21|nvim-spectre||
|22|nvim-surround||
|23|nvim-surround||
|24|nvim-tree.lua||
|25|nvim-treesitter||
|26|nvim-web-devicons||
|27|ouroboros||
|28|packer.nvim||
|29|plenary.nvim||
|30|telescope.nvim||
|31|toggleterm.nvim||
|32|vim-visual-multi||
